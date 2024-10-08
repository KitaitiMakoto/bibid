Bibid::App.controllers :users_books, :parent => :users do
  get :show, :map => 'books/:id' do
    user = User.find_by_name(params[:user_id])
    return halt 404 unless user
    @book = user.books.find_by_id(params[:id])
    return halt 404 unless @book
    render 'books/show'
  end

  post :create, :map => 'books', :require_sign_in => true do
    @book = current_user.books.build(params[:book])
    epub = EPUB::Parser.parse(@book.epub.current_path)
    @book.title = epub&.title || File.basename(@book.epub.filename, '.*')
    if epub
      uid = epub.unique_identifier
      if uid.isbn? and !uid.content.downcase.start_with? 'urn:isbn:'
        @book.unique_identifier = "urn:isbn:#{uid.content}"
      else
        @book.unique_identifier = uid.content
      end
      @book.description = epub.description
      @book.language = epub.metadata.language.to_s
    end
    if current_user.books << @book
      redirect url(:users_books, :show, :user_id => @book.user.name, :id => @book.id), :success => I18n.t('notice.books.create')
    else
      render 'books/new'
    end
  end

  delete :destroy, :map => 'books/:id', :require_sign_in => true do
    @book = current_user.books.find_by_id(params[:id])
    return halt 404 unless @book
    @book.destroy
    redirect url(:users, :show, :name => current_user.name), :success => I18n.t('notice.books.destroy')
  end
end
