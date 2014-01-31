module Airenv
  module Commands
    module Install
      def self.included(thor)
        thor.class_eval do
          desc 'install', 'Fetch and use a AIR SDK of specified version'
          def install(version_id)
            fetch version_id
            use version_id
          end
        end
      end
    end
  end
end
