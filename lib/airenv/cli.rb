require 'thor'

class Airenv::CLI < Thor

  desc 'Prints this version', 'Prints Airenv version'
  def version
    puts "Airenv #{Airenv::VERSION}"
  end

end
