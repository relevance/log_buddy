# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{log_buddy}
  s.version = "0.4.11"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Rob Sanheim"]
  s.date = %q{2009-05-22}
  s.description = %q{Log statements along with their name easily.  Mixin a logger everywhere when you need it.}
  s.email = %q{rsanheim@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.markdown"
  ]
  s.files = [
    ".gitignore",
     ".treasure_map.rb",
     "CHANGELOG",
     "LICENSE",
     "README.markdown",
     "Rakefile",
     "VERSION.yml",
     "examples.rb",
     "examples/log_buddy/example_helper.rb",
     "examples/log_buddy/gem_logger_example.rb",
     "examples/log_buddy/log_buddy_example.rb",
     "examples/log_buddy/log_buddy_init_example.rb",
     "examples/log_buddy/log_example.rb",
     "init.rb",
     "lib/log_buddy.rb",
     "lib/log_buddy/gem_logger.rb",
     "lib/log_buddy/mixin.rb",
     "lib/log_buddy/utils.rb",
     "lib/log_buddy/version.rb",
     "log_buddy.gemspec"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/relevance/log_buddy}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{thinkrelevance}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Log Buddy is your little development buddy.}
  s.test_files = [
    "examples/log_buddy/example_helper.rb",
     "examples/log_buddy/gem_logger_example.rb",
     "examples/log_buddy/log_buddy_example.rb",
     "examples/log_buddy/log_buddy_init_example.rb",
     "examples/log_buddy/log_example.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<spicycode-micronaut>, [">= 0"])
    else
      s.add_dependency(%q<spicycode-micronaut>, [">= 0"])
    end
  else
    s.add_dependency(%q<spicycode-micronaut>, [">= 0"])
  end
end
