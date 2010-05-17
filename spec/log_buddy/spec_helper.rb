require "logger"
require "mocha"
require "rspec"
require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "lib", "log_buddy"))

def silence_warnings
  old_verbose, $VERBOSE = $VERBOSE, nil
  yield
ensure
  $VERBOSE = old_verbose
end

Rspec.configure do |config|
  config.mock_with :mocha
  config.formatter = :documentation
  config.color_enabled = true
  config.alias_example_to :fit, :focused => true
  config.filter_run :options => { :focused => true }
  config.run_all_when_everything_filtered = true
end
