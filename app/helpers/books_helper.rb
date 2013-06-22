# Helper methods defined here can be accessed in any controller or view in the application

Bibid::App.helpers do
  def embedding_tag(book)
    tag :iframe, :src => embedding_url(book)
  end

  def embedding_url(book)
    request_uri = URI(request.url)
    request_uri.path = "/components/bibi/bib/i/"
    request_uri.query = "book=#{book}.epub"
    request_uri.to_s
  end
end
