require 'rails/generators/active_record/migration'

module UcbRails
  # @private
  module Generators
    # @private
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      extend ActiveRecord::Generators::Migration
      source_root File.join(File.dirname(__FILE__), "templates")

      desc 'Copy ucb_rails files'
      class_option :readme, aliases: '-r', type: :boolean, desc: 'Display README and exit'
      
      def install
        return if options.readme?
        
        directory 'app/assets'
        directory 'app/helpers'
        directory 'app/views'
        directory 'config'
        setup_gems
        `bundle install`

        remove_file 'app/views/layouts/application.html.erb'        
        install_migrations
        switch_to_ar_session_store
        add_to_gitignore
        add_ruby_version_file
        copy_example_config

        generate_ar_session_migration
        generate_user_announcements_installer
        
        configure_development_to_use_mailcatcher
        add_exception_notification_config(:development)
        add_exception_notification_config(:production)
        uncomment_lines "config/initializers/backtrace_silencers.rb", "Rails.backtrace_cleaner.remove_silencers"

        rake "db:migrate"
      end

      def show_readme
        if behavior == :invoke
          readme "README"
        end
      end

      def self.next_migration_number(path)
        unless @prev_migration_nr
          @prev_migration_nr = Time.now.utc.strftime("%Y%m%d%H%M%S").to_i
        else
          @prev_migration_nr += 1
        end
        @prev_migration_nr.to_s
      end
      
      private
      
      def add_exception_notification_config(env)
        app_name = Rails.application.class.parent_name
        application(nil, env: env) do
          <<-RUBY
          config.middleware.use ExceptionNotification::Rack,
            :email => {
              :email_prefix => "[#{app_name} PROD Error] ",
              :sender_address => '"#{app_name} PROD Exception Notifier" <theeye@berkeley.edu>',
              :exception_recipients => %w(#{app_name.downcase}-developers@lists.berkeley.edu)
            }          
          RUBY
        end
      end

      def add_ruby_version_file
        template ".ruby-version.erb", ".ruby-version"
      end

      def add_to_gitignore
        insert_into_file '.gitignore', gitignore_line('config/ldap.yml'), after: '/tmp'
        insert_into_file '.gitignore', gitignore_line('config/database.yml'), after: '/tmp'
        insert_into_file '.gitignore', gitignore_line('config/config.yml'), after: '/tmp'
      end

      def configure_development_to_use_mailcatcher
        application "config.action_mailer.delivery_method = :smtp", env: :development
        application "config.action_mailer.smtp_settings = { :address => 'localhost', :port => 1025 }", env: :development
        application "config.action_mailer.default_url_options = { host: 'localhost:3000' }", env: :development
      end

      def copy_example_config
        copy_file 'config/config.yml.example', 'config/config.yml'
      end

      def generate_ar_session_migration
        generate "active_record:session_migration"
      end

      def generate_user_announcements_installer
        generate "user_announcements:install"
      end

      def gitignore_line(path)
        %(\n#{path})
      end

      def install_migrations
        template_dir = Pathname.new(self.class.source_root)
        Dir["#{template_dir}/db/migrate/*.rb"].each do |migration_file|
          # migration_template migration_file
          # puts migration_file
          relative_name = Pathname.new(migration_file).relative_path_from(Pathname.new(template_dir))
          migration_template migration_file, relative_name
        end
      end

      def setup_gems
        # these need to be put manually by user in order
        # to get access to this generator
        # gem 'ucb_ldap'
        # gem 'ucb_rails_ci'
        # gem 'ucb_rails'

        gem 'pg'
        gem "exception_notification", "4.0.1", :require => "exception_notification"
        gem 'responders', '~> 2.0'
        gem 'simple_form'
        gem 'will_paginate', '~> 3.0.6'
        gem 'activerecord-session_store'        

        gem_group :development, :test do
          gem 'capybara'
          gem 'capybara-webkit'
          gem 'factory_girl'
          gem 'launchy'
          gem 'database_cleaner'
          gem 'rspec-rails'
          gem 'spring-commands-rspec'
          gem 'quiet_assets'
          gem 'mailcatcher'
        end                

        gem_group :development do 
          gem 'launchy'
          gem 'better_errors'
          gem 'binding_of_caller'
          gem "redcarpet"
          gem "yard"
          gem 'quiet_assets'
          gem 'thin'
          gem 'capistrano-rails'

        end
      end

      def switch_to_ar_session_store
        gsub_file 'config/initializers/session_store.rb', 'cookie_store', 'active_record_store'
      end
    end
  end
end