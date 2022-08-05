source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.7.4"

# START: Gems out of the box
gem "rails", "~> 7.0.3"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "sprockets-rails"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
# END

gem "bcrypt", "~> 3.1.7"
gem "bootsnap", require: false

group :development, :test do 
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem "rspec-rails"
  gem "faker"
end

