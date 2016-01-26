# UCB Rails (Rails 4 Compatible, see master branch for Rails 3)

Get a jump start on your Rails project at UCB.  Includes:

* CalNet authentication with [omniauth-cas](https://github.com/dlindahl/omniauth-cas)
* LDAP integration with [ucb_ldap](https://rubygems.org/gems/ucb_ldap)
* includes several other gems including:
  * [bootstrap-view-helpers](https://github.com/ucb-ist-eas/bootstrap-view-helpers/tree/rails4)
  * [user_announcements](https://github.com/stevedowney/user_announcements)
  * [rails_environment](https://github.com/stevedowney/rails_environment)

## Installation

Add it to your Gemfile

```ruby
gem 'ucb_rails'
# 'bootstrap-view-helpers' needs to be added as well
gem 'bootstrap-view-helpers', github: 'ucb-ist-eas/bootstrap-view-helpers', branch: 'rails4'
```

From the command line, install the `ucb_rails` gem:

```sh
bundle install
rails g ucb_rails:install
```

Run installers for included gems:

```sh
rails generate user_announcements:install
rails generate simple_form:install --bootstrap
```

Run migrations:

```sh
rake db:migrate
```

Remove superseded files:

```sh
rm public/index.html
```

Add includes to application stylesheet

```ruby
 *= require bootstrap-datepicker3
```

Add includes to application javascript
```ruby
//= require bootstrap-datepicker
```

Restart your server and point your browser to:

```
http://<your_app>/ucb_rails
```

You'll be able to CalNet authenticate.  Successful authentiation will redirect
you to `root_path`.  `ucb_rails` defines `root_path` but the definition in your
host app (if any) will take precedence.


## View Helper Methods

* `current_ldap_person`
* `logged_in?`
 
## Upgrading From An Older Version

If you're upgrading from a version older than March 2015, you'll need to run an extra migration in the project that contains the ucb_rails gem. This will add an `alternate_email` column to your users table.

```
cp ucb_rails/dummy/db/migrate//20150318234744_add_alternate_email_to_users.rb [YOUR_PROJECT_ROOT]/db/migrate
```
