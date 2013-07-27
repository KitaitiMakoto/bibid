source 'https://rubygems.org'

# Distribute your app as a gem
# gemspec

# Server requirements
# gem 'thin' # or mongrel
# gem 'trinidad', :platform => 'jruby'

# Optional JSON codec (faster performance)
# gem 'oj'

# Project requirements
gem 'rake'

# Component requirements
gem 'therubyracer'
gem 'rack-less'
gem 'less'
gem 'erubis', '~> 2.7.0'

# Test requirements

# Padrino Stable Gem
gem 'padrino', '0.11.2'

# Or Padrino Edge
# gem 'padrino', :github => 'padrino/padrino-framework'

# Or Individual Gems
# %w(core gen helpers cache mailer admin).each do |g|
#   gem 'padrino-' + g, '0.11.2'
# end

gem 'dotenv'

gem 'activerecord', '~> 3', :require => 'active_record'
gem 'pg'
gem 'foreigner'
gem 'kaminari', '0.14.1', :require => 'kaminari/sinatra'

gem 'sprockets', '~> 2.2.1'
gem 'http_accept_language', '2.0.0.pre'
gem 'coffee-script'
gem 'carrierwave', :require => %w[carrierwave carrierwave/orm/activerecord]
gem 'omniauth'
gem 'omniauth-twitter'
gem 'omniauth-facebook'

gem 'rack-zip', :github => 'KitaitiMakoto/rack-zip', :require => 'rack/zip'
gem 'epub-parser', :require => 'epub/parser'

gem 'mina'
gem 'triglav-client', :require => 'triglav/client'

group :test do
  gem 'test-unit', :require => 'test/unit'
  gem 'test-unit-rr', :require => 'test/unit/rr'
  gem 'test-unit-capybara', :require => 'test/unit/capybara'
  gem 'test-unit-notify', :require => 'test/unit/notify'
  gem 'shoulda'
  gem 'rack-test', :require => 'rack/test'
  gem 'poltergeist'
end
