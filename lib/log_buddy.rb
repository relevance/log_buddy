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
  VERSION = '0.0.1'

  def self.init(options = {})
    @logger = options[:default_logger]
    mixin_to_object
  end
  
  def self.mixin_to_object
    Object.class_eval { 
      include LogBuddy::Mixin
      extend LogBuddy::Mixin
    }
  end
  
  def self.default_logger
    return @logger if @logger
    @logger = init_default_logger
  end
  
  def self.init_default_logger
    if Object.const_defined?("RAILS_DEFAULT_LOGGER")
      @logger = Object.const_get("RAILS_DEFAULT_LOGGER")
    else
      require 'logger'
      @logger = Logger.new(STDOUT)
    end
  end

  def self.debug(str)
    default_logger.debug(str)
  end
  
  def self.parse_args(logged_line)
    block_args = logged_line[/\{(.*)\}/, 1].strip
  end
  
  def self.read_line(frame)
    file, line_number = frame.split(/:/, 2)
    line_number = line_number.to_i
    lines = File.readlines(file)
    
    lines[line_number - 1]
  end
  
  module Mixin
    def d(msg = nil, &blk)
      LogBuddy.debug(msg) if msg
      return unless block_given?
      logged_line = LogBuddy.read_line(caller[0])
      arguments = LogBuddy.parse_args(logged_line)
      result = eval(arguments, blk.binding)
      LogBuddy.debug(%[#{arguments} = '#{result}'\n])
    end

    def logger
      LogBuddy.default_logger
    end
  end
  
end