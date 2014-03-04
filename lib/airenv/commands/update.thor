require 'pathname'

module Airenv
  module Commands
    module Update
      def self.included(thor)
        thor.class_eval do
          desc 'update', 'Update a SDK version'
          def update(version_id)
            clean
            install version_id
          end
        end
      end
    end
  end
end
