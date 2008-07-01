Gem::Specification.new do |s|
  s.name = %q{log_buddy}
  s.version = "0.0.3"

  s.required_rubygems_version = Gem::Requirement.new("= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Rob Sanheim - Relevance"]
  s.date = %q{2008-07-01}
  s.description = %q{Log statements along with their name easily.  Mixin a logger everywhere when you need it.}
  s.email = %q{opensource@thinkrelevance.com}
  s.extra_rdoc_files = ["CHANGELOG", "README.rdoc", "lib/log_buddy.rb"]
  s.files = ["CHANGELOG", "Manifest", "README.rdoc", "Rakefile", "examples.rb", "init.rb", "lib/log_buddy.rb", "test/test_log_buddy.rb", "log_buddy.gemspec"]
  s.has_rdoc = true
  s.homepage = %q{http://opensource.thinkrelevance.com/wiki/log_buddy}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Log_buddy", "--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{thinkrelevance}
  s.rubygems_version = %q{1.2.0}
  s.summary = %q{Log Buddy is your little development buddy.}
  s.test_files = ["test/test_log_buddy.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if current_version >= 3 then
      s.add_development_dependency(%q<echoe>, [">= 0"])
      s.add_development_dependency(%q<allison>, [">= 0"])
      s.add_development_dependency(%q<markaby>, [">= 0"])
    else
      s.add_dependency(%q<echoe>, [">= 0"])
      s.add_dependency(%q<allison>, [">= 0"])
      s.add_dependency(%q<markaby>, [">= 0"])
    end
  else
    s.add_dependency(%q<echoe>, [">= 0"])
    s.add_dependency(%q<allison>, [">= 0"])
    s.add_dependency(%q<markaby>, [">= 0"])
  end
end
