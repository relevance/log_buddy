require File.join(File.dirname(__FILE__), *%w[log_buddy utils])
require File.join(File.dirname(__FILE__), *%w[log_buddy mixin])
require File.join(File.dirname(__FILE__), *%w[log_buddy gem_logger])
require File.join(File.dirname(__FILE__), *%w[log_buddy version])

=begin rdoc
LogBuddy is a developer tool for easy logging while testing, debugging, and inspecting.
  
The log shortcut method to give you easy, concise output of variables with their names and values.

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
  # * <tt):log_to_stdout</tt> - whether LogBuddy should _also_ log to STDOUT, very helpful for Autotest (default is +true+).
  # * <tt>:disabled</tt> - when true, LogBuddy will not produce any output
  # * <tt>:log_gems</tt> - log Gem activation process - useful for tracking down Gem activation errors (default is +false+)
  def self.init(options = {})
    @logger = options[:logger]
    @log_to_stdout = options.has_key?(:log_to_stdout) ? options[:log_to_stdout] : true
    @log_gems = options[:log_gems]
    @disabled = (options[:disabled] == true)
    mixin_to_object
    GemLogger.log_gems! if @log_gems
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
    
    private
    
    def init_default_logger
      if Object.const_defined?("RAILS_DEFAULT_LOGGER")
        @logger = Object.const_get("RAILS_DEFAULT_LOGGER")
      else
        require 'logger'
        @logger = Logger.new(STDOUT)
      end
    end
    
  end
end