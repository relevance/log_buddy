require 'rubygems'
require "test/unit"
require "test/spec"
require "test/spec/should-output"
require 'mocha'
require 'logger'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "lib", "log_buddy"))

module SomeModule
  def self.say_something(name)
    "#{message} #{name}"
  end
  
  def self.message
    "hello"
  end
end

describe "LogBuddy" do
  describe "object extensions" do
    it "mixes itself into Object instance and class level by default" do
      Object.expects(:include).with(LogBuddy::Mixin)
      Object.expects(:extend).with(LogBuddy::Mixin)
      LogBuddy.init
    end
    
    it "adds logger method to Object instance and class" do
      LogBuddy.init
      Object.new.should.respond_to :logger
      Object.should.respond_to :logger
    end
    
    it "uses RAILS_DEFAULT_LOGGER if its defined" do
      begin
        Object.const_set "RAILS_DEFAULT_LOGGER", stub_everything
        LogBuddy.init
        Object.logger.should == RAILS_DEFAULT_LOGGER
      ensure 
        Object.send :remove_const, "RAILS_DEFAULT_LOGGER"
      end
    end
    
    it "uses a plain STDOUT Ruby logger if there is no RAILS_DEFAULT_LOGGER" do
      LogBuddy.init
      Object.logger.should == LogBuddy.default_logger
    end
    
    it "can override the default logger" do
      file_logger = Logger.new "test.log"
      LogBuddy.init :default_logger => file_logger
      Object.logger.should == file_logger
    end
  end
  
  describe "outputting the code being logged and its result" do
    before { LogBuddy.init }
    it "should log to default logger" do
      LogBuddy.expects(:default_logger).returns(logger = mock)
      logger.expects(:debug).with(anything)
      d {'hi'}
    end
    
    it "should log a plain arg" do
      LogBuddy.expects(:debug).with('hi')
      d 'hi'
    end
    
    it "logs both if given an arg and a block" do
      LogBuddy.expects(:debug).with('hi mom')
      LogBuddy.expects(:debug).with(%[foo = 'foo'\n])
      foo = "foo"
      d("hi mom") { foo }
    end
    
    it "does nothing without a block" do
      should.not.raise { d }
    end
    
    it "should output only local vars in the block" do
      LogBuddy.expects(:debug).with(%[a = 'foo'\n])
      b = "bad"
      a = "foo"
      d { a }
    end
  
    it "should output instance vars" do
      LogBuddy.expects(:debug).with(%[@a = 'foo'\n])
      @a = "foo"
      d { @a }
    end
    
    it "should output constants" do
      FOO_CONST = "yo!"
      LogBuddy.expects(:debug).with(%[FOO_CONST = 'yo!'\n])
      d { FOO_CONST }
    end
  
    it "should output class vars" do
      LogBuddy.expects(:debug).with(%[@@class_var = 'hi'\n])
      @@class_var = "hi"
      d { @@class_var }
    end
  
    it "should output method calls" do
      LogBuddy.expects(:debug).with(%[SomeModule.say_something("dude!!!!") = 'hello dude!!!!'\n])
      d { SomeModule.say_something("dude!!!!") }
    end 
    
    it "should output multiple things with each having their own log calls" do
      local1 = '1'
      local2 = '2'
      @ivar1 = '1'
      LogBuddy.expects(:debug).with(%[local1 = '1'\n])
      LogBuddy.expects(:debug).with(%[local2 = '2'\n])
      LogBuddy.expects(:debug).with(%[@ivar1 = '1'\n])
      d { local1; local2; @ivar1 }
    end
  end
end