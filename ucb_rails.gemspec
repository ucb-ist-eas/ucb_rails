$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "ucb_rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "ucb_rails"
  s.version     = UcbRails::VERSION
  s.authors     = ["Steve Downey", "Peter Philips", "Tyler Minard", "Darin Wilson"]
  s.email       = ["darinwilson@berkeley.edu"]
  s.homepage    = "https://github.com/ucb-ist-eas/ucb_rails"
  s.summary     = "Jumpstart a UCB Rails application"
  s.license     = "MIT"

  s.files = `git ls-files`.split("\n")
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 4.2"

  s.add_dependency "sass-rails", "~> 5.0.6"
  s.add_dependency "haml"
  s.add_dependency "haml-rails"
  s.add_dependency "active_attr"

  s.add_dependency "omniauth", "1.1.1"
  s.add_dependency "omniauth-cas", "1.0.0"

  s.add_dependency "ucb_ldap"#, "2.0.0.pre5"

  # TODO: it would be nice to remove these, but that involves some rewriting
  s.add_dependency "bootstrap-view-helpers", "~> 0.0.14"
  s.add_dependency "rails_view_helpers", "~> 0.0.4"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails", "~> 3.5"

end
