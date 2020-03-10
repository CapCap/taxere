# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'taxere/version'

Gem::Specification.new do |spec|
  spec.name          = "taxere"
  spec.version       = Taxere::VERSION
  spec.authors       = ["Max"]
  spec.email         = ["max@guideline.com"]

  spec.summary       = %q{Ruby port of Taxee, calculate us income taxes and such}
  spec.homepage      = "https://github.com/CapCap/taxere"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "byebug", "~> 9.0"
  spec.add_development_dependency "rake", ">= 12.3.3"
  spec.add_development_dependency "minitest", "~> 5.8.4"
  spec.add_development_dependency "minitest-reporters", "~> 1.1.13"
end
