require 'thor'
require 'active_support/inflector'

class Airenv::CLI < Thor

  desc 'version', 'Prints Airenv version'
  def version
    puts "Airenv #{Airenv::VERSION}"
  end

  def self.load_thorfiles(dir)
    thor_files = Dir.glob('**/*.thor').delete_if { |x| not File.file?(x) }
    thor_files.each do |f|
      load f
      include f.to_s.gsub('lib/', '').gsub('.thor', '').camelize.constantize
    end
  end

end
