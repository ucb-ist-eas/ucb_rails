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

  s.add_dependency "rails", "~> 4.2"
  s.add_dependency "jquery-rails"
  # https://github.com/rails/jquery-rails
  # current: 4.3.3 @ 2018-05-24 👍

  # Enable this gems when pushed to ruby gems
  s.add_dependency 'ucb_ldap', '>= 3.1.1'
  # https://github.com/ucb-ist-eas/ucb-ldap
  # current: 3.0.0 @ 2018-05-24 👍

  # s.add_dependency 'turbolinks'
  # s.add_dependency 'nprogress-rails', '~> 0.1.6.7'

  s.add_dependency "exception_notification", "~> 4.0.0.rc1"
  # https://github.com/smartinez87/exception_notification
  # current: 4.2.2 @ 2018-05-24 👎
  s.add_dependency "omniauth", '1.1.1'
  # https://github.com/omniauth/omniauth
  # current: 1.8.1 @ 2018-05-24 👎
  s.add_dependency "omniauth-cas", '1.0.0'
  # https://rubygems.org/gems/omniauth-cas/ → https://github.com/dlindahl/omniauth-cas
  # current: 1.1.1 @ 2018-05-24 👎
  s.add_dependency "haml-rails"
  # https://github.com/indirect/haml-rails
  # current: 1.0.0 @ 2018-05-24 👍
  s.add_dependency 'bootstrap-sass', '~> 3.3.6'
  # https://github.com/twbs/bootstrap-sass
  # current: 3.3.7 @ 2018-05-24 👍
  s.add_dependency 'sass-rails', '~> 5.0.4'
  # https://github.com/rails/sass-rails
  # current: 5.0.7 @ 2018-05-24 👍
  # newest:  6.0.0.beta1 @ 2018-05-24
  s.add_dependency 'active_attr'
  # https://github.com/cgriego/active_attr
  # current: 0.10.3 @ 2018-05-24 👍
  s.add_dependency 'simple_form', '~> 3.2.0'
  # https://github.com/plataformatec/simple_form
  # current: 4.0.1
  # older: 3.5.1    @ 2018-05-24 👎
  s.add_dependency "jquery-datatables-rails", '~> 3.3.0'
  # https://github.com/rweng/jquery-datatables-rails
  # current: 3.4.0 @ 2018-05-24 👎
  s.add_dependency 'kaminari'
  # https://github.com/kaminari/kaminari
  # current: 1.1.1 @ 2018-05-24 👍
  s.add_dependency 'momentjs-rails', '>= 2.9.0'
  # https://github.com/derekprior/momentjs-rails
  # current: 2.20.1 @ 2018-05-24 👍
  s.add_dependency 'bootstrap3-datetimepicker-rails', '~> 4.17.37'
  # https://github.com/TrevorS/bootstrap3-datetimepicker-rails
  # current: 4.17.47 @ 2018-05-24 👍
  s.add_dependency 'sweetalert-rails', '~> 0.5.0'
  # https://github.com/sharshenov/sweetalert-rails
  # current: 1.1.3 @ 2018-05-24 👎
  s.add_dependency 'sweet-alert-confirm', '~> 0.4.1'
  # https://rubygems.org/gems/sweet-alert-confirm/ → https://github.com/mois3x/sweet-alert-rails-confirm
  # current: 0.4.1 @ 2018-05-24 👍
  # https://github.com/sweetalert2/sweetalert2/wiki/Migration-from-SweetAlert-to-SweetAlert2
  s.add_dependency 'gon', '~> 6.0.0'
  # https://github.com/gazay/gon
  # current: 6.2.0 @  2018-05-24 👎

  s.add_dependency 'responders', '~> 2.0'
  # https://github.com/plataformatec/responders
  # current: 2.4.0 @ 2018-05-24 👍

  s.add_dependency 'rails_environment', '~> 0.0.3'
  # https://github.com/stevedowney/rails_environment
  # current: 0.0.3 @ 2018-05-24 👍

  s.add_dependency 'rails_view_helpers', '~> 0.0.4'
  # https://github.com/stevedowney/rails_view_helpers
  # current: 0.0.4 @ 2018-05-24 👍
  # NOT: https://github.com/jimmyn/rails_view_helpers
  s.add_dependency 'user_announcements', '~> 0.0.9'
  # https://github.com/stevedowney/user_announcements
  # current: 0.0.8 <---- this is behind ours 😱
  s.add_dependency 'bootstrap-view-helpers', '~> 0.0.14'
  # https://github.com/stevedowney/bootstrap-view-helpers
  # current: 0.0.14 @ 2018-05-24 👍

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
