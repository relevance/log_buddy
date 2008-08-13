require 'rubygems'
require "test/unit"
require "test/spec"
require "test/spec/should-output"
require "mocha"
require File.expand_path(File.join(File.dirname(__FILE__), "..", "lib", "log_buddy"))

def silence_warnings
  old_verbose, $VERBOSE = $VERBOSE, nil
  yield
ensure
  $VERBOSE = old_verbose
end
