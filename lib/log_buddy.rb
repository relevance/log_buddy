module LogBuddy
  # Configure and include LogBuddy into Object.
  # You can pass in any of the following configuration options:
  # 
  # * <tt>:logger</tt> - the logger instance that LogBuddy should use (if not provided, 
  #   tries to default to RAILS_DEFAULT_LOGGER, and then to a STDOUT logger).
  # * <tt):stdout</tt> - whether LogBuddy should _also_ log to STDOUT, very helpful for Autotest (default is +true+).
  def self.init(options = {})
    @logger = options[:logger]
    @log_to_stdout = options.has_key?(:log_to_stdout) ? options[:log_to_stdout] : true
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

require File.join(File.dirname(__FILE__), *%w[log_buddy log])
require File.join(File.dirname(__FILE__), *%w[log_buddy version])
