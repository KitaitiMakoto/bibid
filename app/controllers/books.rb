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

  post :create, :map => '/books', :provides => [:html, :json], :require_sign_in => true do
    uploader = EpubUploader.new
    uploader.store! params[:book]
    case content_type
    when :html
      redirect url(:books, :show, book: uploader.file.basename)
    when :json
      {:uri => embedding_url(uploader.file.basename),
       :src => "/components/bibi/bib/bookshelf/#{uploader.file.basename}.epub"}.to_json
    end
  end

  get :show do
    if @book = params[:book]
      render 'books/show'
    else
      redirect url(:books, :upload)
    end
  end
end
