source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.2'

gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.4', '>= 7.0.4.3'
gem 'sprockets-rails'

gem 'devise'
gem 'pg'

gem 'importmap-rails'

gem 'stimulus-rails'
gem 'turbo-rails'
gem 'view_component'

gem 'jbuilder'

gem 'bootsnap', require: false
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem 'debug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  gem 'sorbet-rails'
  gem 'sorbet-runtime'
  gem 'tailwindcss-rails'
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'factory_bot_rails', '~> 6.2'
  gem 'rspec-rails', '~> 5.0'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers', '~> 4.0'
  gem 'webdrivers'
end
