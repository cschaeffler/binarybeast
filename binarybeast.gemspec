# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'binarybeast/version'

Gem::Specification.new do |gem|
  gem.name          = "binarybeast"
  gem.version       = BinaryBeast::VERSION
  gem.authors       = ["Crispin Schaeffler"]
  gem.email         = ["crispinschaeffler@googlemail.com"]
  gem.description   = %q{Ruby gem to access the binary beast api.}
  gem.summary       = %q{Ruby gem to access the binary beast api.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_runtime_dependency 'httparty'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'turn'
  gem.add_development_dependency 'rake'
end
