Bibid::App.helpers do
  def bibi_url
    '/components/bibi/bib'
  end

  def absolute_bibi_url
    uri(bibi_url, true, false)
  end

  def bookshelf_url(book=nil)
    parts = [absolute_bibi_url, 'bookshelf']
    if book
      parts << Rack::Utils.escape(book.user.name) << Rack::Utils.escape(File.basename(book.epub.current_path))
    end
    parts.join('/')
  end
end
