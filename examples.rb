require 'lib/log_buddy'
LogBuddy.init

a = "foo"
@a = "my var"
@@bar = "class var!"
def bark
 "woof!"
end

module Foo;
  def self.module_method
    "hi!!"
  end
end
  

# LogBuddy calls and their output:

d "hi"                    # hi
d { a }                   # a = "foo"
d { @a }                  # @a = "my var"
d { @@bar }               # @@bar = "class var!"
d { bark }                # bark = "woof!"
d { Foo::module_method }  # Foo::module_method = "hi!!"

hsh = {:foo => "bar", "key" => "value"}
array = [1,2,3,4,"5"]

d { hsh }     
d { array }