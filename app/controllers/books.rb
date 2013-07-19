Bibid::App.controllers :books do
  
  # get :index, :map => '/foo/bar' do
  #   session[:foo] = 'bar'
  #   render 'index'
  # end

  # get :sample, :map => '/sample/url', :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   'Maps to url '/foo/#{params[:id]}''
  # end

  # get '/example' do
  #   'Hello world!'
  # end

  get :index, :map => '/books' do
    @books = Book.all

    render 'books/index'
  end
  
  post :create, :map => '/books', :require_sign_in => true do
    @book = Book.new(params[:book])
    @book.title = EPUB::Parser.parse(@book.epub.current_path).title rescue File.basename(@book.epub.filename, '.*')
    if current_user.books << @book
      redirect url(:books, :show, :id => @book.id), :success => 'Successfully book uploaded'
    else
      render 'books/new'
    end
  end

  get :show, :map => '/books/:id' do
    if @book = Book.find_by_id(params[:id])
      render 'books/show'
    else
      halt 404
    end
  end

  delete :destroy, :map => '/books/:id', :require_sign_in => true do
    if @book = Book.find_by_id(params[:id])
      if current_user == @book.user
        @book.destroy
        redirect url(:users, :show, :name => current_user.name), :success => 'Successfully book deleted'
      else
        halt 403
      end
    else
      halt 404
    end
  end
end
