module LogBuddy
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
      begin
        logged_line = LogBuddy.read_line(caller[0])
        arguments = LogBuddy.parse_args(logged_line)
        arguments.each do |arg|
          LogBuddy.arg_and_blk_debug(arg, blk)
        end
      rescue => e
        LogBuddy.debug "LogBuddy caught an exception: #{e.message}"
      end
    end
  end
end