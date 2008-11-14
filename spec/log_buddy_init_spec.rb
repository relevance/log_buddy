require File.expand_path(File.join(File.dirname(__FILE__), *%w[helper]))

describe LogBuddy do
  describe "init" do
    after  { reset_safe_log_buddy_mode }

    it "doesnt mixin to object if SAFE_LOG_BUDDY is true" do
      LogBuddy.expects(:init).never
      ENV["SAFE_LOG_BUDDY"] = "true"
      load_init
    end

    it "mixin to object if SAFE_LOG_BUDDY is true" do
      LogBuddy.expects(:init).once
      load_init
    end

    def load_init
      silence_warnings do
        load File.join(File.dirname(__FILE__), *%w[.. init.rb])
      end
    end

    def reset_safe_log_buddy_mode
      ENV["SAFE_LOG_BUDDY"] = nil
    end
    
  end

end