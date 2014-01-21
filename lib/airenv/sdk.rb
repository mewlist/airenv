require 'active_support/core_ext'

class Airenv::Sdk

  attr_accessor :description

  def initialize(version_id=nil)
    self.description = Airenv::SdkDescription.new
    parse_version_id(version_id) if version_id.present?
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
end