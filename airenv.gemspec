# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'airenv/version'

Gem::Specification.new do |spec|
  spec.name          = "airenv"
  spec.version       = Airenv::VERSION
  spec.authors       = ["Toshiyuki Hirooka", "Hidenori Doi"]
  spec.email         = ["toshi.hirooka@gmail.com", "mewlist@mewlist.com"]
  spec.description   = %q{Automatically download, archive, switch AIR SDK for flash builder on mac.}
  spec.summary       = %q{Adobe AIR SDK package manager}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "thor"
  spec.add_dependency "activesupport"
  spec.add_dependency "i18n"
  spec.add_dependency "progressbar"
  spec.add_dependency "configuration"
  spec.add_dependency "rubyzip"
  spec.add_dependency "archive-tar-minitar"
  spec.add_dependency "bzip2-ruby-rb20"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "pry"
end
