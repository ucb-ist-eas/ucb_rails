require "ucb_rails/engine"
require 'ucb_rails/log_tagger'

require 'haml'
require 'haml-rails'
require 'turbolinks'
require 'nprogress-rails'
require 'kaminari'
require 'omniauth'
require 'omniauth-cas'
require 'responders'
require 'sass-rails'
require 'bootstrap-sass'
require 'active_attr'
require 'simple_form'
require 'jquery-datatables-rails'
require 'exception_notification'
require 'momentjs-rails'
require 'bootstrap3-datetimepicker-rails'
require 'sweetalert-rails'
require 'sweet-alert-confirm'

require 'rails_environment'
require 'ucb_ldap'
require 'rails_view_helpers'
require 'user_announcements'
require 'bootstrap-view-helpers'
  
module UcbRails
  
  def self.logger
    @logger ||= LogTagger.new('UcbRails', Rails.logger)
  end
  
end
