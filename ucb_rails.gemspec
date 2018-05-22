$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "ucb_rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "ucb_rails"
  s.version     = UcbRails::VERSION
  s.authors     = ["Steve Downey"]
  s.email       = ["steve.downtown@gmail.com"]
  s.homepage    = "https://github.com/ucb-ist-eas/ucb_rails"
  s.summary     = "Jumpstart a UCB Rails application."
  s.date = Time.now.utc.strftime("%Y-%m-%d")

  s.files = `git ls-files`.split("\n")

  s.add_dependency "rails"
  s.add_dependency "jquery-rails"

  # Enable this gems when pushed to ruby gems
  s.add_dependency 'ucb_ldap', '2.0.0.pre8'
  s.add_dependency 'ucb_rails_ci', '~> 1.0.1'

  # s.add_dependency 'turbolinks'
  # s.add_dependency 'nprogress-rails', '~> 0.1.6.7'
  s.add_dependency "exception_notification", "~> 4.0.0.rc1"
  s.add_dependency "omniauth", '1.1.1'
  s.add_dependency "omniauth-cas", '1.0.0'
  s.add_dependency "haml-rails"
  s.add_dependency 'bootstrap-sass', '~> 3.3.6'
  s.add_dependency 'sass-rails', '~> 5.0.4'
  s.add_dependency 'active_attr'
  s.add_dependency 'simple_form', '~> 3.2.0'
  s.add_dependency "jquery-datatables-rails", '~> 3.3.0'
  s.add_dependency 'kaminari'
  s.add_dependency 'momentjs-rails', '>= 2.9.0'
  s.add_dependency 'bootstrap3-datetimepicker-rails', '~> 4.17.37'
  s.add_dependency 'sweetalert-rails', '~> 0.5.0'
  s.add_dependency 'sweet-alert-confirm', '~> 0.4.1'
  s.add_dependency 'gon', '~> 6.0.0'

  s.add_dependency 'responders', '~> 2.0'

  s.add_dependency 'rails_environment', '~> 0.0.3'

  s.add_dependency 'rails_view_helpers', '~> 0.0.4'
  s.add_dependency 'user_announcements', '~> 0.0.9'
  s.add_dependency 'bootstrap-view-helpers', '~> 0.0.14'

  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "capybara"
  s.add_development_dependency "capybara-webkit"
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "guard-spork"
  s.add_development_dependency 'coveralls'
  s.add_development_dependency 'shoulda-matchers'
  s.add_development_dependency 'database_cleaner'

  s.add_development_dependency "sqlite3"

  if ENV['ENGINE_DEVELOPER'] == 'true'
    s.add_development_dependency 'launchy'
    s.add_development_dependency 'better_errors'
    s.add_development_dependency 'binding_of_caller'
    s.add_development_dependency "redcarpet"
    s.add_development_dependency "yard"
    s.add_development_dependency 'quiet_assets'
    s.add_development_dependency 'thin'
  end

end
