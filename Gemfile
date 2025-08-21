require_relative "version"

source "https://rubygems.org"
ruby Foobara::ActiveRecordType::MINIMUM_RUBY_VERSION

gemspec

gem "foobara-dotenv-loader", "< 2.0.0"
# including this in test mode to test setting default serializers
gem "foobara-rails-command-connector", "< 2.0.0" # , path: "../rails-command-connector"

gem "rake"

group :development do
  gem "foobara-rubocop-rules", "< 2.0.0"
  gem "guard-rspec"
  gem "rubocop-rake"
  gem "rubocop-rspec"
end

group :development, :test do
  gem "pry"
  gem "pry-byebug"
  # TODO: Just adding this to suppress warnings seemingly coming from pry-byebug. Can probably remove this once
  # pry-byebug has irb as a gem dependency
  gem "irb"
end

group :test do
  gem "foobara-spec-helpers", "< 2.0.0"
  gem "rspec"
  gem "rspec-its"
  gem "ruby-prof"
  gem "simplecov"
  gem "sqlite3"
  gem "vcr"
  gem "webmock"
end
