require File.expand_path(File.join(File.dirname(__FILE__), *%w[example_helper]))

describe LogBuddy::GemLogger do

  describe "starting Gem logging" do
    
    it "includes GemLogger into Gem when #log_gems! is called" do
      Gem.expects(:include).with(LogBuddy::GemLogger)
      LogBuddy::GemLogger.log_gems!
    end
    
  end

  if RUBY_VERSION =! '1.9.1'
    
    describe "Gem#activation monkey patching for logging" do
      
      before do 
        LogBuddy.init
        LogBuddy::GemLogger.log_gems!
      end

      it "should log the gem name and version and where it was called from" do
        Gem.stubs(:activate_without_logging)
      
        LogBuddy.expects(:debug).with do |msg|
          msg.should include(%[Gem activation for gem: 'gem-name' version: '0.5' called from:\n])
          gem_calling_line = __LINE__ + 3
          msg.should include(%[examples/log_buddy/gem_logger_example.rb:#{gem_calling_line}])
        end
        gem "gem-name", "0.5"
      end
    
      it "should do the original gem activation call" do
        LogBuddy.stubs(:debug)
        Gem.expects(:activate_without_logging).with('gem-name', ">= 1.0.0")
        gem "gem-name", ">= 1.0.0"
      end
    
      it "should add alias gem_without_logging" do
        Gem.should respond_to(:activate)
        Gem.should respond_to(:activate_without_logging)
      end
      
    end

  end
  
end
