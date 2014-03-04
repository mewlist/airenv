require 'fileutils'

module Airenv
  module Commands
    module Clean
      def self.included(thor)
        thor.class_eval do
          desc 'clean', 'Clean a temporary directory.'
          def clean
            dir = Settings.temporary_sdk_file_directory
            FileUtils.rm_r(dir) if Dir.exists?(dir)
          end
        end
      end
    end
  end
end
