require 'configuration'

module Airenv
  module Configuration
    def temporary_sdk_file_path(simple_name)
      File.expand_path("#{temporary_sdk_file_directory}/#{simple_name}.zip")
    end

    def temporary_sdk_file_directory
      File.expand_path("#{envdir}/tmp/sdks/")
    end
  end
end

def default_config_string
  <<EOS
Settings = Configuration.for('config') {
  envdir '~/.airenv'
}
EOS
end

path = File.expand_path '~/.airenvconfig.rb'
unless File.exists? path
  File.open(path, 'w') do |file|
    file.write(default_config_string)
  end
end

Kernel.load(path)
Configuration.__send__(:include, Airenv::Configuration)
