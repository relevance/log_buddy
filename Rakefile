begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "log_buddy"
    gem.summary = %Q{Log Buddy is your little development buddy.}
    gem.description = %Q{Log statements along with their name easily.  Mixin a logger everywhere when you need it.}
    gem.email = "rsanheim@gmail.com"
    gem.homepage = "http://github.com/relevance/log_buddy"
    gem.authors = ["Rob Sanheim"]
    gem.add_development_dependency "micronaut", ">= 0.3.0"
    gem.add_development_dependency "mocha", ">= 0.3.0"
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install jeweler"
end

begin 
  require 'micronaut/rake_task'
  
  Micronaut::RakeTask.new(:examples) do |examples|
    examples.pattern = 'examples/**/*_example.rb'
    examples.ruby_opts << '-Ilib -Iexamples'
  end

  Micronaut::RakeTask.new(:rcov) do |examples|
    examples.pattern = 'examples/**/*_example.rb'
    examples.rcov_opts = %[-Ilib -Iexamples --exclude "gems/*,/Library/Ruby/*,config/*" --text-summary  --sort coverage]
    examples.rcov = true
  end

  task :default => [:check_dependencies, :rcov]
rescue LoadError => e
  puts "Micronaut not available to run tests.  Install it with: sudo gem install spicycode-micronaut -s http://gems.github.com"
  puts e
  puts e.backtrace
end

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  if File.exist?('VERSION.yml')
    require 'yaml'
    config = YAML.load(File.read('VERSION.yml'))
    version = "#{config[:major]}.#{config[:minor]}.#{config[:patch]}"
  else
    version = ""
  end

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "log_buddy #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
