require 'active_support/core_ext'
require 'progressbar'
require 'archive/tar/minitar'
require 'fileutils'
require 'bzip2'

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
    parse_sdk_description
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

  def extract_archive
    FileUtils.mkdir_p(extracted_dir)
    system("tar zxf #{Settings.temporary_sdk_file_path(simple_name)} -C #{extracted_dir}")
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

  def current_sdk_symlink_path
    "#{Settings.sdks_directory}/current"
  end
end