require 'pathname'

module Airenv
  module Commands
    module List
      def self.included(thor)
        thor.class_eval do
          desc 'list', 'List fetched SDKs up'
          def list
            Airenv::SdkDescription.installed_versions.each do |version_id|
              sdk = Airenv::Sdk.new(version_id)
              puts "#{sdk.description.version} (#{sdk.simple_version})"
            end
          end
        end
      end
    end
  end
end
