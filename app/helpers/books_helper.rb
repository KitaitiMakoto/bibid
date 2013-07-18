# Helper methods defined here can be accessed in any controller or view in the application

Bibid::App.helpers do
  # @todo Make width and height customizable
  def embedding_tag(book)
    content_tag(:iframe, :src => embedding_url(book), :width => '100%', :height => '100%') {''}
  end

  def embedding_url(book)
    request_uri = URI(request.url)
    request_uri.path = "/components/bibi/bib/i/"
    request_uri.query = "book=#{escape book.user.name}%2F#{escape File.basename(book.epub.current_path)}"
    request_uri.to_s
  end
end
