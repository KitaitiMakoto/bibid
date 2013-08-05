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
    keep_sandbox_file_count
    @book = Book.new(params[:book])
    @book.user = User.new(name: '')

    if @book.epub.size > settings.sandbox_file_size_limit
      @book.errors.add :epub, I18n.translate(
        'sandbox.over_file_size',
        epub:  number_to_human_size(@book.epub.size),
        limit: number_to_human_size(settings.sandbox_file_size_limit)
      )
    else
      @book.epub.store!
    end
    if @book.errors.empty? and @book.valid?
      redirect url(:sandbox, :show, filename: @book.epub.filename), :success => I18n.translate('notice.books.create')
    else
      render 'sandbox/new'
    end
  end

  delete :destroy, :map => '/sandbox/:filename' do
    redirect url(:sandbox, :new) unless params[:filename]
    file_path = File.join(Padrino.root, 'public', 'uploads', File.basename(params[:filename]))
    if File.exist? file_path
      File.delete file_path
    end
    redirect url(:sandbox, :new), :success => I18n.t('notice.books.destroy')
  end
end
