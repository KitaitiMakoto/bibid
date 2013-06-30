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
  
  get :upload do
    render 'books/upload'
  end

  post :upload, :provides => [:html, :json] do
    uploader = EpubUploader.new
    uploader.store! params[:book]
    case content_type
    when :html
      redirect url(:books, :show, book: uploader.file.basename)
    when :json
      {:src => "/components/bibi/bib/bookshelf/#{uploader.file.basename}.epub", :embedded => "/components/bibi/bib/i/?book=#{uploader.file.basename}.epub"}.to_json
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
