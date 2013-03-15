Gem::Specification.new do |s|
  s.name = %q{epp}
  s.version = "0.0.6"
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Synctree Inc."]
  s.date = %q{2013-02-13}
  s.description = %q{A full suite of EPP commands that you can add to any model}
  s.email = %q{appforce@synctree.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.homepage = %q{http://github.com/synctree/epp}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{0.0.6}
  s.summary = %q{EPP (Extensible Provisioning Protocol) commands for rails models}

  if s.respond_to? :specification_version then

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('0.0.1') then
      s.add_development_dependency(%q<shoulda>, [">= 0"])
      s.add_development_dependency(%q<mocha>, [">= 0"])
      s.add_runtime_dependency(%q<hpricot>, [">= 0"])
      s.add_runtime_dependency(%q<libxml-ruby>, [">= 0"])
    else
      s.add_dependency(%q<shoulda>, [">= 0"])
      s.add_dependency(%q<mocha>, [">= 0"])
      s.add_dependency(%q<hpricot>, [">= 0"])
      s.add_dependency(%q<libxml-ruby>, [">= 0"])
    end
  else
    s.add_dependency(%q<shoulda>, [">= 0"])
    s.add_dependency(%q<mocha>, [">= 0"])
    s.add_dependency(%q<hpricot>, [">= 0"])
    s.add_dependency(%q<libxml-ruby>, [">= 0"])
  end
end

