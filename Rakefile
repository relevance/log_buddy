begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "log_buddy"
    gem.summary = %Q{Log Buddy is your little development buddy.}
    gem.description = %Q{Log statements along with their name easily.  Mixin a logger everywhere when you need it.}
    gem.email = "rsanheim@gmail.com"
    gem.homepage = "http://github.com/relevance/log_buddy"
    gem.authors = ["Rob Sanheim"]
    gem.add_development_dependency "rspec", ">= 2.0.0.beta.8"
    gem.add_development_dependency "mocha", ">= 0.9.0"
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: gem install jeweler"
end

begin 
  require 'rspec/core/rake_task'
  
  Rspec::Core::RakeTask.new(:spec)

  Rspec::Core::RakeTask.new(:coverage) do |spec|
    spec.pattern = 'spec/**/*_spec.rb'
    spec.rcov_opts = %[-Ilib -Ispec --exclude "gems/*,/Library/Ruby/*,config/*" --text-summary  --sort coverage]
    spec.rcov = true
  end

  task :default => [:check_dependencies, :coverage]
rescue LoadError => e
  puts "Rspec not available to run tests.  Install it with: gem install rspec --pre"
  puts e
  puts e.backtrace
end

begin
  %w{sdoc sdoc-helpers rdiscount}.each { |name| gem name }
  require 'sdoc_helpers'
rescue LoadError => ex
  puts "sdoc support not enabled:"
  puts ex.inspect
end

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ''
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "log_buddy #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
