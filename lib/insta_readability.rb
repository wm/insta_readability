require 'insta_readability/version'
require 'insta_readability/configuration'
require 'insta_readability/bookmark'
require 'insta_readability/instapaper_parser'
require 'insta_readability/importer'
require 'insta_readability/cli'

module InstaReadability
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration) if block_given?

    Readit::Config.consumer_key    = configuration.api_key
    Readit::Config.consumer_secret = configuration.api_secret
  end
end
