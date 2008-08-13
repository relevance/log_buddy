require 'rubygems'
require "test/unit"
require "test/spec"
require "test/spec/should-output"

describe "LogBuddy init" do
  def load_init
    load File.join(File.dirname(__FILE__), *%w[.. init.rb])
  end

  after { ENV["SAFE_LOG_BUDDY"] = nil }
  
  it "doesnt mixin to object if SAFE_LOG_BUDDY is true" do
    ENV["SAFE_LOG_BUDDY"] = "true"
    load_init
    lambda { Object.new.d }.should.raise NoMethodError
  end
  
  it "mixin to object if SAFE_LOG_BUDDY is true" do
    load_init
    Object.new.d
  end

end