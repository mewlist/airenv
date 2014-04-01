require 'thor'
require 'active_support/inflector'

class Airenv::CLI < Thor

  desc 'version', 'Prints Airenv version'
  def version
    puts "Airenv #{Airenv::VERSION}"
  end

  def self.load_thorfiles(dir)
    thor_files = Dir.glob(File.join("#{dir}", "**/*.thor")).delete_if { |x| not File.file?(x) }
    thor_files.each do |f|
      load f
      include "airenv/commands#{File.expand_path(f.to_s).gsub(File.expand_path(dir), '')}".gsub('.thor', '').camelize.constantize
    end
  end

end
