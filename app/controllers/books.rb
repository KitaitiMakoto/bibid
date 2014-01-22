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
    @books = Book.order('created_at DESC').page(params[:page])

    render 'books/index'
  end

  get :show, :map => '/books/:id' do
    book = Book.find(params[:id])
    return halt 404 unless book
    redirect url(:users_books, :show, :user_id => book.user.name, :id => book.id), 301
  end
end
