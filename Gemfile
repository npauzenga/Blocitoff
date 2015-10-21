source "https://rubygems.org"

gem "rails", "4.2.4"
gem "sass-rails", "~> 5.0"
gem "uglifier", ">= 1.3.0"
gem "coffee-rails", "~> 4.1.0"
gem "jquery-rails"
gem "turbolinks"
gem "jbuilder", "~> 2.0"
gem "sdoc", "~> 0.4.0", group: :doc
gem "faker"
gem "figaro", "1.0"
gem "pry-rails"

group :development, :test do
  # Call "byebug" anywhere in the code to stop execution and get a debugger
  gem "byebug"
  gem "rspec-rails", "~> 3.0"
  gem "capybara"
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem "web-console", "~> 2.0"
  # Spring speeds up development by keeping your application running
  gem "spring"
  gem "guard"
  gem "guard-rubocop"
  gem "rubocop-rspec"
  gem "binding_of_caller"
  gem "better_errors"
  gem "sqlite3"
end

group :production do
  gem "pg"
  gem "rails_12factor"
end
