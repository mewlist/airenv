require 'thor'

class Airenv::CLI < Thor

  desc 'version', 'Prints Airenv version'
  def version
    puts "Airenv #{Airenv::VERSION}"
  end

end
