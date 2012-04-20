require File.expand_path(File.join(File.dirname(__FILE__), *%w[spec_helper]))

describe LogBuddy do

  it "has logger" do
    LogBuddy.should respond_to(:logger)
  end

  it "has stdout config option" do
    LogBuddy.should respond_to(:log_to_stdout?)
  end

  it "can override the default logger" do
    file_logger = Logger.new "test.log"
    LogBuddy.init :logger => file_logger
    LogBuddy.logger.should == file_logger
  end

  describe "init" do
    it "defaults to log to stdout (as well as logger)" do
      LogBuddy.init
      LogBuddy.log_to_stdout?.should == true
    end

    it "can be configured to log to stdout" do
      LogBuddy.init :stdout => false
      LogBuddy.log_to_stdout?.should == true
    end

    it "defaults to not using awesome_print for object inspection" do
      LogBuddy.init
      LogBuddy.use_awesome_print?.should == false
    end

    it "can be configured to use awesome_print for object inspection" do
      LogBuddy.init :use_awesome_print => true
      LogBuddy.use_awesome_print?.should == true
    end
  end

end
