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
  s.add_dependency 'ucb_rails_ci'

  # s.add_dependency 'turbolinks'
  # s.add_dependency 'nprogress-rails', '~> 0.1.6.7'
  s.add_dependency "exception_notification"
  s.add_dependency "omniauth"
  s.add_dependency "omniauth-cas"
  s.add_dependency "haml-rails"
  s.add_dependency 'bootstrap-sass'
  s.add_dependency 'sass-rails'
  s.add_dependency 'active_attr'
  s.add_dependency 'simple_form'
  s.add_dependency "jquery-datatables-rails"
  s.add_dependency 'kaminari'
  s.add_dependency 'momentjs-rails'
  s.add_dependency 'bootstrap3-datetimepicker-rails'
  s.add_dependency 'sweetalert-rails'
  s.add_dependency 'sweet-alert-confirm'
  s.add_dependency 'gon'

  s.add_dependency 'responders'

  s.add_dependency 'rails_environment'

  s.add_dependency 'rails_view_helpers'
  s.add_dependency 'user_announcements'
  s.add_dependency 'bootstrap-view-helpers'

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
