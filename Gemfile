source "https://rubygems.org"

gem "rails", "4.2.4"
gem "sass-rails", "~> 5.0"
gem "uglifier", ">= 1.3.0"
gem "coffee-rails", "~> 4.1.0"
gem "jquery-rails"
gem "turbolinks"
gem "jbuilder", "~> 2.0"
gem "sdoc", "~> 0.4.0", group: :doc
gem "figaro", "1.0"
gem "puma"
gem "bcrypt"
gem "responders", "~>2.0"
gem "whenever"
gem "interactor"
gem "normalize-rails"

group :test do
  gem "coveralls"
  gem "simplecov"
end

group :development, :test do
  gem "faker"
  gem "pry-rails"
  gem "byebug"
  gem "pry-byebug"
  gem "rspec-rails", "~> 3.0"
  gem "capybara"
  gem "guard"
  gem "guard-rubocop"
  gem "guard-rspec"
  gem "rubocop"
  gem "rubocop-rspec"
  gem "factory_girl_rails", "~> 4.0"
  gem "shoulda-matchers", "~> 3.0"
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem "web-console", "~> 2.0"
  # Spring speeds up development by keeping your application running
  gem "spring"
  gem "binding_of_caller"
  gem "better_errors"
  gem "sqlite3"
end

group :production do
  gem "pg"
  gem "rails_12factor"
end
