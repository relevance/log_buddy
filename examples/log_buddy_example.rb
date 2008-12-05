require File.expand_path(File.join(File.dirname(__FILE__), *%w[example_helper]))

describe LogBuddy do
  
  it "has logger" do
    LogBuddy.should respond_to(:logger)
  end
  
  it "has stdout config option" do
    LogBuddy.should respond_to(:log_to_stdout?)
  end
  
  describe "init" do
    it "mixes itself into Object instance and class level by default" do
      Object.expects(:include).with(LogBuddy::Mixin)
      Object.expects(:extend).with(LogBuddy::Mixin)
      LogBuddy.init
    end

    it "adds logger method to Object instance and class" do
      LogBuddy.init
      Object.new.should respond_to(:logger)
      Object.should respond_to(:logger)
    end
    
    it "defaults to log to stdout (as well as logger)" do
      LogBuddy.init
      LogBuddy.log_to_stdout?.should == true
    end

    it "can be configured to log to stdout" do
      LogBuddy.init :stdout => false
      LogBuddy.log_to_stdout?.should == true
    end
  end

end