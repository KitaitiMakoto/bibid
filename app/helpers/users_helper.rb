# Helper methods defined here can be accessed in any controller or view in the application

Bibid::App.helpers do
  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def opds_from_user(user)
    RSS::Maker.make('atom') {|maker|
      maker.channel.about = absolute_url(:users, :show, :name => user.name)
      maker.channel.title = "#{user.display_name}'s books"
      maker.channel.author = user.display_name
      maker.channel.generator = "BiB/i'd"
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
      books = user.books.order(:created_at).all
      maker.channel.updated = books.empty? ? user.updated_at : books.last.created_at
      books.each do |book|
        begin
          epub = EPUB::Parser.parse(book.epub.current_path)
          maker.items.new_item do |entry|
            uid = epub.unique_identifier
            if uid.isbn? and !uid.content.downcase.start_with? 'urn:isbn:'
              entry.id = "urn:isbn:#{h uid.content}"
            else
              entry.id = uid.content
            end
            entry.title = epub.title
            entry.summary = epub.description
            entry.updated = book.updated_at
            entry.links.new_link do |link|
              link.rel = RSS::OPDS::RELATIONS['acquisition']
              link.href = File.join(absolute_url(:root, :index), 'components/bibi/bib/bookshelf', user.name, File.basename(book.epub.current_path))
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
end
