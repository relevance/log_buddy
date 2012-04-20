require 'bundler/gem_tasks'

begin
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new(:spec)

  RSpec::Core::RakeTask.new(:coverage) do |spec|
    spec.pattern = 'spec/**/*_spec.rb'
    spec.rcov_opts = %[-Ilib -Ispec --exclude "gems/*,/Library/Ruby/*,config/*" --text-summary  --sort coverage]
    spec.rcov = true
  end

  require "yaml"
  RubyVersions = YAML.load_file(".travis.yml")["rvm"]
  desc "Run Rspec against multiple Rubies: #{RubyVersions.join(", ")}"
  task :spec_all do
    cmd = %[bash -c 'source ~/.rvm/scripts/rvm; rvm #{RubyVersions.join(",")} do rake spec']
    puts cmd
    system cmd
  end


  if RUBY_VERSION <= "1.8.7"
    task :default => [:coverage]
  else
    task :default => [:spec]
  end
rescue LoadError => e
  puts "Rspec not available to run tests.  Install it with: gem install rspec --pre"
  puts e
  puts e.backtrace
end
