require 'readit'
require 'singleton'
require 'insta_readability/auth'
require 'insta_readability/instapaper_parser'

module InstaReadability
  class CLI
    include Singleton
    USAGE_MESSAGE = "Usage: $0 PATH_TO_CSV_FILE"
    attr_reader :auth

    def initialize
      @auth = Auth.get_access_token
    end

    def self.run(csv_path='')
      if csv_path == ''
        $stderr.print USAGE_MESSAGE
        return
      end

      parser   = InstaReadability.configuration.parser.new csv_path
      importer = InstaReadability::Importer.new(instance.auth.token, instance.auth.secret)
      importer.import parser.create_bookmarks
    end
  end
end
