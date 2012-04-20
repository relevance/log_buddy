# -*- encoding: utf-8 -*-
require File.expand_path('../lib/log_buddy/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Rob Sanheim"]
  gem.email         = ["rsanheim@gmail.com"]
  gem.description   = %q{Log statements along with their name easily.  Mixin a logger everywhere when you need it.}
  gem.summary       = %q{Log Buddy is your little development buddy.}
  gem.homepage      = %q{http://github.com/relevance/log_buddy}

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "log_buddy"
  gem.version       = LogBuddy::Version::STRING
  gem.add_development_dependency 'rspec', "~> 2.8"
  gem.add_development_dependency 'mocha', "~> 0.9"
  gem.add_development_dependency "rake", "~> 0.9.2"
  gem.add_development_dependency 'bundler', '~> 1.1'
end
