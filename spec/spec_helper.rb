require 'bourne'
require 'mocha/api'
require 'vcr'
require 'ostruct'
require 'insta_readability'

RSpec.configure do |config|
  config.mock_with :mocha
end
