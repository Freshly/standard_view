$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "standard_view/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "standard_view"
  spec.version     = StandardView::VERSION
  spec.authors     = [ "Eric Garside", "Brandon Trumpold" ]
  spec.email       = %w[eric.garside@freshly.com brandon.trumpold@gmail.com]
  spec.homepage    = "https://github.com/Freshly/standard_view"
  spec.summary     = "A highly functional and largely automated presentation layer."
  spec.description = "Use Bootstrap to present a nicely standardized view for your models."
  spec.license     = "MIT"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", ">= 5.2.3"
  spec.add_dependency "material", ">= 0.3.8", "< 1.0"
  spec.add_dependency "spicery", ">= 0.23.7", "< 1.0"
  spec.add_dependency "law", ">= 0.1.7", "< 1.0"
  spec.add_dependency "simple_form", ">= 4.1", "< 5.1"
  spec.add_dependency "will_paginate", "~> 3.1.1"

  spec.add_development_dependency "bundler", "~> 2.0.1"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec-rails", "~> 3.8.2"
  spec.add_development_dependency "simplecov", "~> 0.16"
  spec.add_development_dependency "faker", "~> 1.8"
  spec.add_development_dependency "sqlite3", "~> 1.3.6"

  spec.add_development_dependency "rspice", ">= 0.22.3.1", "< 1.0"
  spec.add_development_dependency "spicerack-styleguide", ">= 0.22.3.1", "< 1.0"
  spec.add_development_dependency "rspec-html-matchers"
end
