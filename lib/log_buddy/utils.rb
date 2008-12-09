module LogBuddy
  module Utils
  
    def obj_to_string(obj)
      case obj
      when ::String
        obj
      when ::Exception
        "#{ obj.message } (#{ obj.class })\n" <<
          (obj.backtrace || []).join("\n")
      else
        obj.inspect
      end
    end
    
    def debug(str)
      stdout_puts(str) if log_to_stdout?
      logger.debug(str)
    end
  
    def stdout_puts(str)
      puts str
    end
  
    # Returns array of arguments in the block
    # You must ues the brace form (ie d { "hi" }) and not do...end
    def parse_args(logged_line)
      block_contents = logged_line[/\{(.*)\}/, 1]
      args = block_contents.split(";").map {|arg| arg.strip }
    end
  
    # Return the calling line
    def read_line(frame)
      file, line_number = frame.split(/:/, 2)
      line_number = line_number.to_i
      lines = File.readlines(file)
    
      lines[line_number - 1]
    end
  end
end