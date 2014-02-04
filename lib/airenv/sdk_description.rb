require 'rexml/document'
require 'digest/md5'

class Airenv::SdkDescription
  include Comparable

  attr_accessor :name
  attr_accessor :version
  attr_accessor :build

  def initialize(name=nil, version=nil, build=nil)
    self.name = name
    self.version = version
    self.build = build
  end

  def load(xml)
    @doc = parse(xml)
    root = @doc.elements['air-sdk-description']
    self.name = root.elements['name'].text
    self.version = root.elements['version'].text
    self.build = root.elements['build'].text.to_i
  end

  def parse(xml)
    REXML::Document.new xml
  end

  def id
    "#{version}-b#{build}"
  end

  def digest
    Digest::MD5.digest(id)
  end

  def <=>(other)
    result = self.version <=> other.version
    if result == 0
      self.build <=> other.build
    else
      result
    end
  end

  class << self
    def normalize_version_id(version_id)
      if simple_version?(version_id)
        installed_sdks.select {|sdk|
          sdk.simple_version == version_id
        }.sort.last.description.id
      else
        version_id
      end
    end

    def usable?(version_id)
      installed_sdks.map {|sdk| [sdk.description.id, sdk.simple_version] }.flatten.include? version_id
    end

    def installed_sdks
      installed_versions.map {|version| Airenv::Sdk.new(version) }
    end

    def simple_version?(version_id)
      not version_id.include?("-b")
    end

    def installed_versions
      Dir.glob("#{Settings.sdks_directory}/*").map {|f|
        Pathname.new(f).basename.to_s
      }.reject {|basename| basename == 'current' }.map {|basename|
        basename.to_s.gsub("AIRSDK_", '')
      }
    end
  end
end