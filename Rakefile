require 'rubygems'
gem 'echoe'
gem "spicycode-micronaut", ">= 0.2.0"
require 'echoe'
require 'micronaut'
require 'micronaut/rake_task'
require File.join(File.dirname(__FILE__), *%w[lib log_buddy version])

echoe = Echoe.new('log_buddy', LogBuddy::VERSION::STRING) do |p|
  p.rubyforge_name = 'thinkrelevance'
  p.author = 'Rob Sanheim - Relevance'
  p.email = 'opensource@thinkrelevance.com'
  p.summary = 'Log Buddy is your little development buddy.'
  p.description = 'Log statements along with their name easily.  Mixin a logger everywhere when you need it.'
  p.url = "http://github.com/relevance/log_buddy"
  p.rdoc_pattern = /^(lib|bin|ext)|txt|rdoc|gemspec|CHANGELOG|LICENSE$/
  rdoc_template = `allison --path`.strip << ".rb"
  p.rdoc_template = rdoc_template
end

Rake.application.instance_variable_get(:@tasks).delete("default")
Rake.application.instance_variable_get(:@tasks).delete("test")

desc "Run all examples"
Micronaut::RakeTask.new(:examples)

namespace :examples do
  desc "Run all examples using rcov"
  Micronaut::RakeTask.new :coverage do |t|
    t.rcov = true
    t.rcov_opts = %[--exclude "gems/*,/Library/Ruby/*,config/*" --text-summary  --sort coverage --no-validator-links]
  end
end

task :default => 'examples:coverage'

# The below results in 'input stream exhausted' - dunno why?
# task :release => [:test, :publish_docs, :announce]

echoe.spec.add_development_dependency "echoe"
echoe.spec.add_development_dependency "allison"
echoe.spec.add_development_dependency "markaby"
echoe.spec.add_development_dependency "spicycode-micronaut"