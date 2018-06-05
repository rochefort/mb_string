# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "mb_string/version"

Gem::Specification.new do |spec|
  spec.name          = "mb_string"
  spec.version       = MbString::VERSION
  spec.authors       = ["rochefort"]
  spec.email         = ["terasawan@gmail.com"]

  spec.summary       = "You can use mb_ljust, mb_rjust, mb_center for multibyte strings."
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/rochefort/mb_string"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "unicode-display_width", ">= 1.3", "< 1.5"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake", "~> 12.3.1"
  spec.add_development_dependency "rspec", "~> 3.7.0"
  spec.add_development_dependency "simplecov", "~> 0.12.0"

  spec.add_development_dependency "coveralls", "~> 0.8.19"
  spec.add_development_dependency "codeclimate-test-reporter", "~> 1.0.8"
end
