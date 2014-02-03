require 'shellwords'

module Airenv
  module Commands
    module Init
      def self.included(thor)
        thor.class_eval do
          desc 'init', 'Initialize Airenv for first use'
          def init
            puts "To attempt to remove Flash Builder system directory then making a symbolic link instead of the directory."
            puts "  REMOVES: #{Settings.flash_builder_airsdk_path}"
            puts "  SYMLINK: #{Settings.flash_builder_airsdk_path} -> #{Settings.current_sdk_symlink_path}"
            puts "Do you permit to do it? [yN]"
            answer = STDIN.gets.chomp
            if ['y', 'Y'].include? answer
              if File.symlink?(Settings.flash_builder_airsdk_path)
                File.delete(Settings.flash_builder_airsdk_path)
              end
              File.symlink(Settings.current_sdk_symlink_path, Settings.flash_builder_airsdk_path)
              puts "Airenv is initialized for your environment."
            else
              puts "All are cancelled. Did nothing."
            end
          end
        end
      end
    end
  end
end
