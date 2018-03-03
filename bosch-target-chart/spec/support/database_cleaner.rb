require 'database_cleaner'

RSpec.configure do |config|
  config.use_transactional_fixtures = true

  config.before(:suite) do
    # Use the truncation strategy for tests
    DatabaseCleaner.strategy = :transaction
    # Truncate tables before the suite to clear all data
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    # Run DatabaseCleaner around each test
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
