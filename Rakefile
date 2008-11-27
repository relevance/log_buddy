require 'rubygems'
gem 'echoe'
require 'echoe'
require File.join(File.dirname(__FILE__), *%w[lib log_buddy version])

echoe = Echoe.new('log_buddy', LogBuddy::VERSION::STRING) do |p|
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

Rake.application.instance_variable_get(:@tasks).delete("default")
Rake.application.instance_variable_get(:@tasks).delete("test")

namespace :micronaut do
  
  desc 'Run all examples'
  task :examples do
    examples = Dir["examples/**/*_example.rb"].map { |g| Dir.glob(g) }.flatten
    examples.map! {|f| %Q(require "#{f}")}
    command = "-e '#{examples.join("; ")}'"
    ruby command
  end
  
  desc "Run all examples using rcov"
  task :coverage do
    examples = Dir["examples/**/*_example.rb"].map { |g| Dir.glob(g) }.flatten
    system "rcov --exclude \"examples/*,gems/*,db/*,/Library/Ruby/*,config/*\" --text-report --sort coverage --no-validator-links #{examples.join(' ')}"
  end
  
end

task :default => 'micronaut:coverage'

# The below results in 'input stream exhausted' - dunno why?
# task :release => [:test, :publish_docs, :announce]

echoe.spec.add_development_dependency "echoe"
echoe.spec.add_development_dependency "allison"
echoe.spec.add_development_dependency "markaby"