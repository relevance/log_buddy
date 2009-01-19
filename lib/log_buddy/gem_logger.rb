module LogBuddy
  module GemLogger

    BACKTRACE_SIZE = 0..5
    
    def self.log_gems!
      Gem.send :include, LogBuddy::GemLogger
    end
    
    def self.included(mod)

      class << mod
        def activate_with_logging(gem, *version_requirements)
          d %[Gem activation for gem: '#{gem}' version: '#{version_requirements}' called from:\n#{caller[BACKTRACE_SIZE].join("\n")}]
          activate_without_logging(gem, *version_requirements)
        end

        alias_method :activate_without_logging, :activate
        alias_method :activate, :activate_with_logging
      end
      
    end
  end
end