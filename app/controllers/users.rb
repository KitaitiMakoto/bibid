Bibid::App.controllers :users do
  
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
  
  get :index do
    
  end

  get :new do
    unless session[:auth]
      redirect '/sessions/login'
    end
    @user = User.new(session[:auth].slice(:name, :display_name))
    @user.authentications.build session[:auth].slice(:provider, :uid)
    session.delete :auth

    render 'users/new'
  end

  get :show, :map => '/users/:name' do
    
  end

  post :create, :map => '/users' do
    @user = User.new(params[:user].slice('name', 'display_name'))
    @user.authentications.build(params[:authentication])
    @user.save!

    redirect url(:users, :show, :name => @user.name)
  end

  put :update, :map => '/users/:name' do
    
  end

  delete :destroy, :map => '/users/:name' do
    
  end

end
