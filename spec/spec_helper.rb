$LOAD_PATH << File.expand_path('../..', __FILE__)

RSpec.configure do |config|
  config.expect_with(:rspec) { |c| c.syntax = :should }
end
