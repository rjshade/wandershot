source 'http://rubygems.org'

gem 'rails', '>= 3.2.11'

gem 'thin'                    # faster webserver than webrick
gem 'simple_form'             # nice form helpers
gem 'haml-rails',  '>= 0.3.4' # better templating
gem 'bson_ext',    '>= 1.3.1' # binary json for mongodb
gem 'mongoid',     '>= 2.2.3' # ORM for mongodb
gem 'mongoid_slug'            # friendly urls with mongoid
gem 'devise',      '>= 1.4.9' # authentication
gem 'cancan'                  # role-based authorization
gem 'heroku'                  # cli for heroku
gem 'maruku',      '~> 0.6.0' # markdown
gem 'truncate_html'           # truncate html text
# paperclip for file uploads
gem 'paperclip', :git => "git://github.com/thoughtbot/paperclip.git"
gem 'mongoid-paperclip', :require => "mongoid_paperclip"
gem 'aws-sdk'                 # to talk to amazon s3
gem 'aws-s3'                  # to talk to amazon s3
gem 'omniauth-facebook'       # login with facebook

group :development do
  gem 'guard-cucumber'
  gem 'guard-spork'
  gem 'growl'
end

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier',     '>= 1.0.3'
  gem 'twitter-bootstrap-rails'
end

gem 'jquery-rails'

group :test do
  gem 'database_cleaner',   '>= 0.6.7'
  gem 'mongoid-rspec',      '>= 1.4.4'
  gem 'factory_girl_rails', '>= 1.3.0'
  gem 'cucumber-rails',     '>= 1.1.1', require: false
  gem 'capybara',           '>= 1.1.1'
  gem 'launchy',            '>= 2.0.5'
  gem 'rspec-rails',        '~> 2.11.0'
  gem 'spork-rails'
end

