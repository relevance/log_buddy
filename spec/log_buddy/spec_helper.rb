require "logger"
require "rspec"
require "mocha"
require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "lib", "log_buddy"))

def silence_warnings
  old_verbose, $VERBOSE = $VERBOSE, nil
  yield
ensure
  $VERBOSE = old_verbose
end

RSpec.configure do |config|
  config.filter_run :focused => true
  config.run_all_when_everything_filtered = true
  config.color_enabled = true
  config.alias_example_to :fit, :focused => true
  config.formatter = :documentation
  config.mock_with :mocha
end
