# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'harness/action_subscriber/version'

Gem::Specification.new do |spec|
  spec.name          = "harness-action_subscriber"
  spec.version       = Harness::ActionSubscriber::VERSION
  spec.authors       = ["mmmries"]
  spec.email         = ["michael@riesd.com"]
  spec.summary       = "Record statsd metrics about ActionSubscriber via Harness"
  spec.description   = spec.description
  spec.homepage      = "https://github.com/mxenabled/harness-action_subscriber"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_runtime_dependency "activesupport", ">= 3.2"
  spec.add_runtime_dependency "harness", ">= 2.0.0"
  spec.add_runtime_dependency "action_subscriber", ">= 2.0.0"
end
