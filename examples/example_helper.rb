require 'logger'
require 'rubygems'
gem 'spicycode-micronaut', "~> 0.1.0"
gem 'mocha'
require "mocha"
require 'micronaut'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "lib", "log_buddy"))

def silence_warnings
  old_verbose, $VERBOSE = $VERBOSE, nil
  yield
ensure
  $VERBOSE = old_verbose
end

Micronaut.configure do |config|
  config.mock_with :mocha
end

Micronaut::Runner.autorun