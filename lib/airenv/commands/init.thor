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
              system("rm #{Shellwords.escape(Settings.flash_builder_airsdk_path)}")
              system("ln -s #{Shellwords.escape(Settings.current_sdk_symlink_path)} #{Shellwords.escape(Settings.flash_builder_airsdk_path)}")
            else
              puts "All are cancelled. Did nothing."
            end
          end
        end
      end
    end
  end
end
