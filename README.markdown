# LogBuddy

## DESCRIPTION

log_buddy is your friendly little log buddy at your side, helping you dev, debug, and test.

[![Build Status](https://secure.travis-ci.org/relevance/log_buddy.png?branch=master)](http://travis-ci.org/relevance/log_buddy)

## SYNOPSIS

Require the init.rb file to use log_buddy.  By default, it will add two methods to every object at the instance and class level: "d" and "logger".  To use log_buddy without the automatic object intrusion, set ENV["SAFE_LOG_BUDDY"] = true before requiring the init.rb.

You can use your own logger with LogBuddy by passing it into init's options hash:

    LogBuddy.init :logger => Logger.new('my_log.log')

Now you have your logger available from any object, at the instance level and class level:

    obj = Object.new
    obj.logger.debug("hi") # logs to 'my_log.log'
    class MyClass; end
    MyClass.logger.info("heya") # also logs to 'my_log.log'

You also have a method called "d" (for "debug") on any object, which is used for quick debugging and logging of things while you are developing.
Its especially useful while using autotest.  When you call the "d" method with an inline block, it will log the name of the things
in the block and the result.  Examples:

    a = "foo"
    @a = "my var"
    @@bar = "class var!
    def bark
     "woof!"
    end

    d { a }      # logs "a = 'foo'"
    d { @a }     # logs "@a = 'my var'"
    d { @@bar }  # logs "@@bar = 'class var!'"
    d { bark }   # logs "bark = woof!"


See examples.rb for live examples you can run.

When you occasionally want to disable LogBuddy (but you don't want to have to remove all your debug statements), you can pass the :disabled option into init's options hash:

	LogBuddy.init :disabled => true

## REQUIREMENTS

* Ruby 1.8.7 and greater or JRuby

## ISSUES

* This is meant for non-production use while developing and testing --> it does stuff that is slow and you probably don't want happening in your production environment.
* Don't even try using this in irb.

## INSTALL

	gem install log_buddy

## URLS

* File Issues: http://github.com/relevance/log\_buddy/issues
* View Source: http://github.com/relevance/log\_buddy
* Git clone Source: git://github.com/relevance/log\_buddy.git
* Documentation: http://rdoc.info/gems/log\_buddy

## LICENSE

(The MIT License)

Copyright (c) 2009 Relevance, Inc. - http://thinkrelevance.com

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
