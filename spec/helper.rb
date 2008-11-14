require 'rubygems'
gem 'rspec'
gem 'mocha'
require "mocha"
require 'spec'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "lib", "log_buddy"))

def silence_warnings
  old_verbose, $VERBOSE = $VERBOSE, nil
  yield
ensure
  $VERBOSE = old_verbose
end

Spec::Runner.configure do |config|
  config.mock_with :mocha
end