require 'logger'
module InstaReadability
  class Importer
    def initialize(token, secret, logger=::Logger.new($stderr))
      @logger = logger
      @api    = Readit::API.new token, secret
    end

    def import(bookmarks)
      bookmarks.each do |bm|
        status = save bm
        update status['bookmark_id'], bm if status['status'] == '409'
        @logger.info status
      end
    end

    def save(bookmark)
      @api.bookmark bookmark.to_hash
    end

    def update(id, bookmark)
      @api.update_bookmark id, bookmark.to_hash
    end
  end
end
