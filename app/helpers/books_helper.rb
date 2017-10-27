Bibid::App.helpers do
  def embedding_tag(book, options={})
    options = {:'data-bibi' => 'embed', :'data-bibi-style' => 'width: 100%; height: 100%;'}.merge(options)
    link_to(book.title, embedding_url(book), options) +
      content_tag(:script, '', :src => absolute_bibi_url + '/i.js', :type => 'text/javascript')
  end

  def embedding_url(book)
    request_uri = URI(request.url)
    request_uri.path = "/components/bibi/bib/i/"
    request_uri.query = "book=#{escape book.user.name}%2F#{escape File.basename(book.epub.current_path)}"
    request_uri.to_s
  end

  def cover_image_url(book)
    epub = EPUB::Parser.parse(book.epub.current_path)
    return unless epub.cover_image
    epub.cover_image.entry_name
  end
end
