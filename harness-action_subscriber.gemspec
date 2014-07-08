# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'harness/action_subscriber/version'

Gem::Specification.new do |spec|
  spec.name          = "harness-action_subscriber"
  spec.version       = Harness::ActionSubscriber::VERSION
  spec.authors       = ["hqmq"]
  spec.email         = ["michael@riesd.com"]
  spec.summary       = "Log ActionSubscriber stats via Harness"
  spec.description   = spec.description
  spec.homepage      = "https://git.moneydesktop.com/dev/harness-action_subscriber"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'special_delivery'

  spec.add_runtime_dependency "harness", ">= 2.0.0"
  spec.add_runtime_dependency "action_subscriber", ">= 1.0.2"
end
