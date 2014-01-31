require 'pathname'

module Airenv
  module Commands
    module List
      def self.included(thor)
        thor.class_eval do
          desc 'list', 'List fetched SDKs up'
          def list
            Dir.glob("#{Settings.sdks_directory}/*") do |f|
              basename = Pathname.new(f).basename.to_s
              unless basename  == 'current'
                sdk = Airenv::Sdk.new(basename.to_s.gsub("AIRSDK_", ''))
                puts "#{sdk.description.version} (#{sdk.simple_version})"
              end
            end
          end
        end
      end
    end
  end
end
