# -*- coding: utf-8 -*-
Bibid::App.controllers :sandbox do
  
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

  get :new, :map => '/sandbox/new' do
    render 'sandbox/new'
  end

  get :show, :map => '/sandbox/:filename' do
    redirect url(:sandbox, :new) unless params[:filename]
    file_path = File.join(Padrino.root, 'public', 'uploads', File.basename(params[:filename]))
    halt 404 unless File.exist? file_path
    file = File.open(file_path)
    @book = Book.new
    @book.user = User.new(name: '')
    @book.epub = {:tempfile => file}
    @book.title = EPUB::Parser.parse(file_path).title rescue nil
    render 'sandbox/show'
  end

  post :create, :map => '/sandbox' do
    book = Book.new(params[:book])
    book.user = User.new(name: '')
    book.epub.store!
    keep_sandbox_file_count
    redirect url(:sandbox, :show, filename: book.epub.filename), :success => I18n.translate('notice.books.create')
  end

  delete :destroy, :map => '/sandbox/:filename' do
    redirect url(:sandbox, :new) unless params[:filename]
    file_path = File.join(Padrino.root, 'public', 'uploads', File.basename(params[:filename]))
    if File.exist? file_path
      File.delete file_path
    end
    redirect url(:sandbox, :new)
  end
end
