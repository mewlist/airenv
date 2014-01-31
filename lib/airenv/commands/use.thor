module Airenv
  module Commands
    module Use
      def self.included(thor)
        thor.class_eval do
          desc 'use', 'Change current to ready to use a AIR SDK of specified version'
          def use(version_id)
            sdk = Airenv::Sdk.new version_id
            sdk.use
            puts "Switched to #{sdk.description.name}."
          end
        end
      end
    end
  end
end
