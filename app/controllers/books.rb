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
  
  get :new, :require_sign_in => true do
    render 'books/new'
  end

  post :create, :map => '/books', :require_sign_in => true do
    book = Book.new
    book.epub = params[:book]
    if book.save
      redirect url(:books, :show, :id => book.id)
    else
      redirect url(:books, :new)
    end
  end

  get :show, :map => '/books/:id' do
    if @book = Book.find(params[:id])
      render 'books/show'
    else
      redirect url(:books, :upload)
    end
  end
end
