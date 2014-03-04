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
              current_mark = if sdk.current? then "*" else " " end
              puts "#{current_mark} #{sdk.description.id} (#{sdk.simple_version})"
            end
          end
        end
      end
    end
  end
end
