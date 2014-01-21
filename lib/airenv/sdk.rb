class Airenv::Sdk

  attr_accessor :description

  def package_uri
   "http://airdownload.adobe.com/air/mac/download/#{simple_version}/AIRSDK_Compiler.tbz2"
  end

  def simple_version
    description.version.split('.')[0..1].join('.')
  end
end