require 'rubygems'
require 'hoe'
require './lib/log_buddy.rb'

Hoe.new('log_buddy', LogBuddy::VERSION) do |p|
  p.rubyforge_name = 'thinkrelevance'
  p.author = 'Rob Sanheim - Relevance'
  p.email = 'opensource@thinkrelevance.com'
  p.summary = 'Log Buddy is your little development buddy.'
  p.description = p.paragraphs_of('README.rdoc', 2..5).join("\n\n")
  p.url = p.paragraphs_of('README.rdoc', 0).first.split(/\n/)[1..-1]
  p.changes = p.paragraphs_of('History.txt', 0..1).join("\n\n")
end
