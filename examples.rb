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
  

d { a }                   # logs "a = 'foo'"
d { @a }                  # logs "@a = 'my var'"
d { @@bar }               # logs "@@bar = 'class var!'"
d { bark }                # logs "bark = woof!"
d { Foo::module_method }  # logs Foo::module_method = 'hi!!'