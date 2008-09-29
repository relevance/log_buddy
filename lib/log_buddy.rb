=begin rdoc
LogBuddy is a developer tool for easy logging while testing, debugging, and inspecting.
  
Log shortcut method to give you easy, concise output of variables with their names and values.

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
class LogBuddy
  VERSION = '0.1.0'

  # Use LogBuddy!
  def self.init(options = {})
    @logger = options[:default_logger]
    mixin_to_object
  end
  
  # Add the LogBuddy::Mixin to Object instance and class level.
  def self.mixin_to_object
    Object.class_eval { 
      include LogBuddy::Mixin
      extend LogBuddy::Mixin
    }
  end
  
  # The main Mixin that gets added on the #init call
  module Mixin
    # This is where the magic happens.  This method can take a plain old string, and it will log 
    # it like any call to Logger#debug.  To get the name of the thing you are logging and its value,
    # use the block form:
    #    d { @a }
    #
    # Seperate with semicolons for multiple things - pretty much any valid ruby will work.
    #    d { @@foo; MY_CONST }
    #    d { @person; @@place; object.method() }
    #
    def d(msg = nil, &blk)
      LogBuddy.debug(msg) if msg
      return unless block_given?
      logged_line = LogBuddy.read_line(caller[0])
      arguments = LogBuddy.parse_args(logged_line)
      arguments.each do |arg|
        result = eval(arg, blk.binding)
        LogBuddy.debug(%[#{arg} = '#{result}'\n])
      end
    end

    # Add a default logger to everything, everywhere.
    def logger
      LogBuddy.default_logger
    end
  end
  
  private
  
  # Default logger LogBuddy will use
  def self.default_logger
    return @logger if @logger
    @logger = init_default_logger
  end
  
  # Attempt to establish a default logger - first try RAILS_DEFAULT_LOGGER,
  # then fallback to default.
  def self.init_default_logger
    if Object.const_defined?("RAILS_DEFAULT_LOGGER")
      @logger = Object.const_get("RAILS_DEFAULT_LOGGER")
    else
      require 'logger'
      @logger = Logger.new(STDOUT)
    end
  end
  
  # Just debug it
  def self.debug(str)
    default_logger.debug(str)
  end
  
  # Returns array of arguments in the block
  # You must ues the brace form (ie d { "hi" }) and not do...end
  def self.parse_args(logged_line)
    block_contents = logged_line[/\{(.*)\}/, 1]
    args = block_contents.split(";").map {|arg| arg.strip }
  end
  
  # Return the calling line
  def self.read_line(frame)
    file, line_number = frame.split(/:/, 2)
    line_number = line_number.to_i
    lines = File.readlines(file)
    
    lines[line_number - 1]
  end
  
end