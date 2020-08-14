source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.6'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.4', '>= 5.2.4.3'

gem 'bcrypt'

gem 'screencap'

gem 'mysql2'


# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

gem 'jquery-rails'

gem 'rspec-rails' , '~> 3.7.1'

gem 'factory_bot_rails', '~> 4.11'

gem 'rails-controller-testing'

gem 'bootstrap-sass','3.3.7'

gem 'dotenv-rails'
gem 'webpacker', github: 'rails/webpacker'

# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'

gem 'faker'

gem 'bootsnap', require: false

gem 'will_paginate', '3.1.7'

gem 'shrine'

gem 'image_processing'
gem 'mini_magick'

gem 'data-confirm-modal'

gem 'rspec_junit_formatter' # for circle ci



gem 'whenever', :require => false

gem 'bootstrap-will_paginate','1.0.0'

gem 'chart-js-rails'

gem 'aws-sdk', '~>1'
gem 'aws-sdk-ses', '~> 1.6'


# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb


group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capistrano'
  gem 'capistrano-bundler'
  gem 'capistrano-rails'
  gem 'capistrano-rbenv'

  gem 'ed25519'
  gem 'bcrypt_pbkdf'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'foreman'
end

group :production, :staging do
    gem 'unicorn'
    gem 'fog-aws'
    gem 'listen', '>= 3.0.5', '< 3.2'
    gem "aws-sdk-s3"

end


group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara'
  #gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'webdrivers'
  gem 'devise'

  gem 'database_cleaner'

  gem "shoulda-matchers"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
