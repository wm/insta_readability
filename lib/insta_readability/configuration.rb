module InstaReadability
  class Configuration
    attr_accessor :api_key, :api_secret, :parser

    def initialize
      self.api_key    = nil
      self.api_secret = nil
      self.parser     = InstapaperParser
    end
  end
end
