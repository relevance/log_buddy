require 'logger'
require 'rubygems'
gem 'spicycode-micronaut', "= 0.0.4"
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

Micronaut::Runner.autorun