# Helper methods defined here can be accessed in any controller or view in the application

Bibid::App.helpers do
  def current_user
    @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
  end

  def opds_from_user(user)
    RSS::Maker.make('atom') {|maker|
      books = user.books.order(:created_at).all
      make_feed_base maker, user, books
      maker.channel.links.new_link do |link|
        link.href = absolute_url(:users, :show, :name => user.name, :format => :opds)
        link.rel = RSS::OPDS::RELATIONS['self']
        link.type = RSS::OPDS::TYPES['acquisition']
      end
      maker.channel.links.new_link do |link|
        link.href = absolute_url(:users, :show, :name => user.name, :format => :opds)
        link.rel = RSS::OPDS::RELATIONS['start']
        link.type = RSS::OPDS::TYPES['acquisition']
      end
      books.each do |book|
        begin
          maker.items.new_item do |entry|
            make_entry_base entry, book
            entry.links.new_link do |link|
              link.rel = RSS::OPDS::RELATIONS['acquisition']
              link.href = File.join(absolute_url('/'), 'components/bibi/bib/bookshelf', user.name, File.basename(book.epub.current_path))
              link.type = EPUB::MediaType::EPUB
            end
          end
        rescue => error
          logger.error error
          logger.error error.backtrace.join("\n")
          logger.error "Skip book id=#{book.id}"
        end
      end
    }
  end

  def rss_from_user(user)
    RSS::Maker.make('2.0') {|maker|
      books = user.books.order(:created_at).all
      make_feed_base maker, user, books
      maker.channel.link = absolute_url(:users, :show, :name => user.name)
      books.each do |book|
        begin
          maker.items.new_item do |item|
            make_entry_base item, book
            item.enclosure.url = File.join(absolute_url(:root, :index), 'components/bibi/bib/bookshelf', user.name, File.basename(book.epub.current_path))
            item.enclosure.length = book.epub.size
            item.enclosure.type = 'document/x-epub'
          end
        rescue => error
          logger.error error
          logger.error error.backtrace.join("\n")
          logger.error "Skip book id=#{book.id}"
        end
      end
    }
  end

  private

  def make_feed_base(maker, user, books)
    maker.channel.about = absolute_url(:users, :show, :name => user.name)
    maker.channel.title = "#{user.display_name}'s books"
    maker.channel.description = maker.channel.title
    maker.channel.author = user.display_name
    maker.channel.generator = "BiB/i'd"
    maker.channel.updated = books.empty? ? user.updated_at : books.last.created_at
  end

  def make_entry_base(entry, book)
    epub = EPUB::Parser.parse(book.epub.current_path)
    uid = epub.unique_identifier
    if uid.isbn? and !uid.content.downcase.start_with? 'urn:isbn:'
      entry.id = "urn:isbn:#{escape uid.content}"
    else
      entry.id = uid.content
    end
    entry.title = epub.title
    entry.summary = epub.description
    entry.updated = book.updated_at
    entry.dc_language = epub.metadata.language
  end
end
