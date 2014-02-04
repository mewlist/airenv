module Airenv
  module Commands
    module Fetch
      def self.included(thor)
        thor.class_eval do
          desc 'fetch', 'Fetches a AIR SDK of specified version'
          def fetch(version_id)
            sdk = Airenv::Sdk.new version_id
            sdk.fetch
            puts "#{sdk.description.name} fetched."
          end
        end
      end
    end
  end
end
