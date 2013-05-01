require 'csv'

module InstaReadability
  class InstapaperParser
    def initialize(csv_path)
      @csv_path = csv_path
    end

    def create_bookmarks
      bookmarks = []

      CSV.foreach(@csv_path, headers: true) do |row|
        bookmark = Bookmark.new ({
          url: row['URL'],
          favorite: row['Folder'] == 'Starred',
          archive: row['Folder'] == 'Archive'
        })
        bookmarks << bookmark
      end

      bookmarks
    end
  end
end
