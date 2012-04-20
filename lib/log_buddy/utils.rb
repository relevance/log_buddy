module LogBuddy
  module Utils

    def debug(obj)
      return if @disabled
      str = obj_to_string(obj)
      stdout_puts(str) if log_to_stdout?
      logger.debug(str)
    end

    def arg_and_blk_debug(arg, blk)
      result = eval(arg, blk.binding)
      result_str = obj_to_string(result, :quote_strings => true)
      LogBuddy.debug(%[#{arg} = #{result_str}\n])
    end

    def stdout_puts(str)
      puts str
    end

    # Returns array of arguments in the block
    # You must use the brace form (ie d { "hi" }) and not do...end
    def parse_args(logged_line)
      block_contents = logged_line[/\{(.*?)\}/, 1]
      args = block_contents ? block_contents.split(";").map {|arg| arg.strip } : []
    end

    # Return the calling line
    def read_line(frame)
      file, line_number = frame.split(/:/, 2)
      line_number = line_number.to_i
      lines = File.readlines(file)

      lines[line_number - 1]
    end

    def obj_to_string(obj, options = {})
      quote_strings = options.delete(:quote_strings)
      case obj
      when ::String
        quote_strings ? %["#{obj}"] : obj
      when ::Exception
        "#{ obj.message } (#{ obj.class })\n" <<
          (obj.backtrace || []).join("\n")
      else
        LogBuddy.use_awesome_print? && obj.respond_to?(:ai) ?
          obj.ai : obj.inspect
      end
    end
  end
end
