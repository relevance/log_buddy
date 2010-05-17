require File.expand_path(File.join(File.dirname(__FILE__), *%w[spec_helper]))

module SomeModule
  def self.say_something(name)
    "#{message} #{name}"
  end
  
  def self.message
    "hello"
  end
  
  def self.raise_runtime_error
    raise RuntimeError
  end
end

describe LogBuddy::Mixin, " behavior" do
    
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
    Object.logger.should == LogBuddy.logger
  end
    
  it "can override the default logger" do
    file_logger = Logger.new "test.log"
    LogBuddy.init :logger => file_logger
    Object.logger.should == file_logger
  end
  
  describe "outputting the code being logged and its result" do
    before { LogBuddy.init :log_to_stdout => false }
    it "should log to default logger" do
      LogBuddy.expects(:logger).returns(logger = mock)
      logger.expects(:debug).with(anything)
      d {'hi man'}
    end
    
    it "should log a plain method call as is, nothing fancy" do
      LogBuddy.expects(:debug).with("hey yo")
      d 'hey yo'
    end
    
    it "logs both argument and resulting value if using block from" do
      LogBuddy.expects(:debug).with("hi mom")
      LogBuddy.expects(:debug).with(%[foo = "foo"\n])
      foo = "foo"
      d("hi mom") { foo }
    end
    
    it "does nothing without a block" do
      lambda { d }.should_not raise_error
    end
    
    it "should output only local vars in the block" do
      LogBuddy.expects(:debug).with(%[a = "foo"\n])
      b = "bad"
      a = "foo"
      d { a }
    end
  
    it "should output instance vars" do
      LogBuddy.expects(:debug).with(%[@a = "foo"\n])
      @a = "foo"
      d { @a }
    end
    
    it "should output constants" do
      FOO_CONST = "yo!"
      LogBuddy.expects(:debug).with(%[FOO_CONST = "yo!"\n])
      d { FOO_CONST }
    end
  
    it "should output class vars" do
      LogBuddy.expects(:debug).with(%[@@class_var = "hi"\n])
      @@class_var = "hi"
      d { @@class_var }
    end
  
    it "should output method calls" do
      LogBuddy.expects(:debug).with(%[SomeModule.say_something("dude!!!!") = "hello dude!!!!"\n])
      d { SomeModule.say_something("dude!!!!") }
    end 
    
    it "should output multiple things with each having their own log calls" do
      local1 = '1'
      local2 = '2'
      @ivar1 = '1'
      LogBuddy.expects(:debug).with(%[local1 = "1"\n])
      LogBuddy.expects(:debug).with(%[local2 = "2"\n])
      LogBuddy.expects(:debug).with(%[@ivar1 = "1"\n])
      d { local1; local2; @ivar1 }
    end
    
    it "should gracefully handle runtimer errors" do
      LogBuddy.expects(:debug).with('LogBuddy caught an exception: RuntimeError')
      d { SomeModule.raise_runtime_error }
    end
    
    it "logs things okay with inline rdoc" do
      LogBuddy.stubs(:debug)
      hsh = {:foo=>"bar", "key"=>"value"}
      d { hsh } # hsh = {:foo=>"bar", "key"=>"value"}
    end
    
    it "logs inspected version of hashes and arrays" do
      hsh = { :peanut_butter => "jelly", "awesome_numbers" => [3,7,22]}
      different_hash_output_orders = [
        %[hsh = {"awesome_numbers"=>[3, 7, 22], :peanut_butter=>"jelly"}\n],
        %[hsh = {:peanut_butter=>"jelly", "awesome_numbers"=>[3, 7, 22]}\n]
      ]
      LogBuddy.logger.expects(:debug).with(any_of(*different_hash_output_orders))
      d { hsh }
    end 
    
  end
  
  describe "obj_to_string" do
    include LogBuddy::Utils
    
    class Foo
      def inspect
        "inspeck yo-self"
      end
    end
    
    it "logs string as-is" do
      obj_to_string("foo").should == "foo"
    end
    
    it "logs exception with exception msg, type, and backtrace" do
      begin 
        raise "bad mojo"
      rescue Exception => exception
        string = obj_to_string(exception)
        string.should match /^bad mojo (RuntimeError)*/
        string.should include(__FILE__)
      end
    end
    
    it "logs all other objects with #inspect" do
      obj_to_string(Foo.new).should == "inspeck yo-self"
    end
  end
  
  describe "stdout" do
    before { Logger.any_instance.stubs(:debug) }
    it "logs to stdout as well as the default logger" do
      LogBuddy.init :log_to_stdout => true
      LogBuddy.expects(:stdout_puts).with(%["foo" = "foo"\n])
      d { "foo" }
    end
    
    it "doesnt log to stdout if stdout configured off" do
      LogBuddy.init :log_to_stdout => false
      LogBuddy.expects(:stdout_puts).never
      d { "foo" }
    end
  end
end