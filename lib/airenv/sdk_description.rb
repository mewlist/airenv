require 'rexml/document'

class Airenv::SdkDescription
  attr_accessor :name
  attr_accessor :version
  attr_accessor :build

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
end