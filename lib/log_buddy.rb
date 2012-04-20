require File.join(File.dirname(__FILE__), *%w[log_buddy utils])
require File.join(File.dirname(__FILE__), *%w[log_buddy mixin])
require File.join(File.dirname(__FILE__), *%w[log_buddy version])

=begin rdoc
LogBuddy is a developer tool for easy logging while testing, debugging, and inspecting.

The <tt>d</tt> log method to give you easy, concise output of variables with their names and values.

Requiring 'log_buddy' will _automatically_ mixin the <tt>d</tt> method into Object.  You can avoid this
behavior by setting SAFE_LOG_BUDDY to true in your environment before requiring LogBuddy.

Examples:
    a = "foo"
    @a = "my var"
    def bark
     "woof!"
    end

    d { a }      # logs "a = 'foo'"
    d { @a }     # logs "@a = 'my var'"
    d { bark }   # logs "bark = woof!"

=end
module LogBuddy
  # Configure and include LogBuddy into Object.
  # You can pass in any of the following configuration options:
  #
  # * <tt>:logger</tt> - the logger instance that LogBuddy should use (if not provided,
  #   tries to default to RAILS_DEFAULT_LOGGER, and then to a STDOUT logger).
  # * <tt>:log_to_stdout</tt> - whether LogBuddy should _also_ log to STDOUT, very helpful for Autotest (default is +true+).
  # * <tt>:disabled</tt> - when true, LogBuddy will not produce any output
  # * <tt>:use_awesome_print</tt> - when true, LogBuddy will log object with awesome_print
  def self.init(options = {})
    @logger = options[:logger]
    @log_to_stdout = options.has_key?(:log_to_stdout) ? options[:log_to_stdout] : true
    @use_awesome_print = options.has_key?(:use_awesome_print) ? options[:use_awesome_print] : false
    @disabled = (options[:disabled] == true)
    mixin_to_object
  end

  # Add the LogBuddy::Mixin to Object instance and class level.
  def self.mixin_to_object
    Object.class_eval {
      include LogBuddy::Mixin
      extend LogBuddy::Mixin
    }
  end

  class << self
    include LogBuddy::Utils
    def logger
      return @logger if @logger
      @logger = init_default_logger
    end

    def log_to_stdout?
      @log_to_stdout
    end

    def use_awesome_print?
      @use_awesome_print
    end

    private

    # First try Rails.logger, then RAILS_DEFAULT_LOGGER (for older
    # versions of Rails), then just use a STDOUT Logger
    def init_default_logger
      @logger = if rails_environment && rails_environment.respond_to?(:logger)
        rails_environment.logger
      elsif Object.const_defined?("RAILS_DEFAULT_LOGGER")
        Object.const_get("RAILS_DEFAULT_LOGGER")
      else
        require 'logger'
        Logger.new(STDOUT)
      end
    end

    def rails_environment
      Object.const_defined?("Rails") && Object.const_get("Rails")
    end

  end

  init unless ENV["SAFE_LOG_BUDDY"]
end
