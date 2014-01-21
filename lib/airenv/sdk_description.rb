require 'rexml/document'
require 'digest/md5'

class Airenv::SdkDescription
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
end