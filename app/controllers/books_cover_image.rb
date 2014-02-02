Bibid::App.controllers :books_cover_image, :parent => [:users, :books] do
  get :show, :map => 'cover-image' do
    user = User.find_by_name(params[:user_id])
    return halt 404 unless user
    book = user.books.find_by_id(params[:book_id])
    return halt 404 unless book
    epub = EPUB::Parser.parse(book.epub.current_path) rescue nil
    return halt 404 unless epub
    cover = epub.cover_image
    return halt 404 unless cover
    response['Content-Type'] = cover.media_type
    cover.read
  end
end
