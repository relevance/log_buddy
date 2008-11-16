require File.join(File.dirname(__FILE__), *%w[lib log_buddy])
LogBuddy.init unless ENV["SAFE_LOG_BUDDY"]