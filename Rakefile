begin
  gem 'technicalpickles-echoe'
rescue LoadError => e
  puts "couldn't find the correct version of echoe - please install from forked version on github: http://github.com/technicalpickles/echoe/"
  puts "gem sources -a http://gems.github.com"
  puts "sudo gem install technicalpickles-echoe"
end

require 'rubygems'
require 'echoe'
require './lib/log_buddy.rb'

echoe = Echoe.new('log_buddy', LogBuddy::VERSION) do |p|
  p.rubyforge_name = 'thinkrelevance'
  p.author = 'Rob Sanheim - Relevance'
  p.email = 'opensource@thinkrelevance.com'
  p.summary = 'Log Buddy is your little development buddy.'
  p.description = 'Log statements along with their name easily.  Mixin a logger everywhere when you need it.'
  p.url = "http://opensource.thinkrelevance.com/wiki/log_buddy"
  p.rdoc_pattern = /^(lib|bin|ext)|txt|rdoc|CHANGELOG|LICENSE$/
  rdoc_template = `allison --path`.strip << ".rb"
  p.rdoc_template = rdoc_template
end

echoe.spec.add_development_dependency "allison"
echoe.spec.add_development_dependency "markaby"