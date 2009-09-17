require 'logger'
require "mocha"
require 'micronaut'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "lib", "log_buddy"))

def silence_warnings
  old_verbose, $VERBOSE = $VERBOSE, nil
  yield
ensure
  $VERBOSE = old_verbose
end

Micronaut.configure do |config|
  config.mock_with :mocha
  config.formatter = :documentation
  config.color_enabled = true
  config.alias_example_to :fit, :focused => true
  config.filter_run :options => { :focused => true }
end
