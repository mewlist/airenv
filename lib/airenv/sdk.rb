require 'active_support/core_ext'
require 'progressbar'
require 'archive/tar/minitar'
require 'fileutils'
require 'bzip2'
require 'shellwords'

class Airenv::Sdk

  attr_accessor :description

  def initialize(version_id=nil)
    self.description = Airenv::SdkDescription.new
    parse_version_id(version_id) if version_id.present?
    parse_sdk_description if archive_extracted?
  end

  def parse_version_id(version_id)
    self.description.version, build = *version_id.split('-b')
    self.description.build = build.to_i if build.present?
  end

  def package_uri
   "http://airdownload.adobe.com/air/mac/download/#{simple_version}/AIRSDK_Compiler.tbz2"
  end

  def simple_version
    description.version.split('.')[0..1].join('.')
  end

  def package_name
    "AIRSDK_#{description.id}"
  end

  def simple_name
    "AIRSDK_#{simple_version}"
  end

  def fetch
    puts "Downloading..."
    download
    puts "Archive extracting..."
    extract_archive
    parse_sdk_description_from_temporary_sdk
    move_to_sdks_directory
  end

  def download
    downloader = Airenv::Downloader.new(package_uri, simple_name)
    if downloader.archive_exists?
      puts "Skipped downloading because the archive exists."
    else
      downloader.start
    end
  end

  def extracted_dir
    "#{Settings.sdks_directory}/#{package_name}"
  end

  def temporary_extracted_dir
    "#{Settings.temporary_sdk_file_extracted_directory}"
  end

  def extract_archive
    FileUtils.mkdir_p(temporary_extracted_dir)
    system("tar zxf #{Shellwords.escape(Settings.temporary_sdk_file_path(simple_name))} -C #{temporary_extracted_dir}")
  end

  def sdk_description_xml_path
    "#{extracted_dir}/air-sdk-description.xml"
  end

  def archive_extracted?
    File.exists?(extracted_dir)
  end

  def sdk_description_xml
    File.read("#{sdk_description_xml_path}")
  end

  def parse_sdk_description
    self.description.load(sdk_description_xml)
  end

  def temporary_sdk_description_xml_path
    "#{temporary_extracted_dir}/air-sdk-description.xml"
  end

  def temporary_sdk_description_xml
    File.read("#{temporary_sdk_description_xml_path}")
  end

  def parse_sdk_description_from_temporary_sdk
    self.description.load(temporary_sdk_description_xml)
  end

  def move_to_sdks_directory
    FileUtils.mkdir_p(Settings.sdks_directory)
    File.rename(temporary_extracted_dir, extracted_dir)
  end

  def current_sdk_symlink_exists?
    File.exists?(Settings.current_sdk_symlink_path)
  end

  def use
    File.delete(Settings.current_sdk_symlink_path) if current_sdk_symlink_exists?
    File.symlink(extracted_dir, Settings.current_sdk_symlink_path)
  end
end