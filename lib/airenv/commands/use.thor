module Airenv
  module Commands
    module Use
      def self.included(thor)
        thor.class_eval do
          desc 'use', 'Change current to ready to use a AIR SDK of specified version'
          def use(version_id)
            if Airenv::SdkDescription.usable?(version_id)
              normalized_version_id = Airenv::SdkDescription.normalize_version_id(version_id)
              sdk = Airenv::Sdk.new normalized_version_id
              sdk.use
              puts "Switched to #{sdk.description.name}."
            else
              puts "The version #{version_id} is not installed on your system. Please use 'install' command to get the version."
            end
          end
        end
      end
    end
  end
end
