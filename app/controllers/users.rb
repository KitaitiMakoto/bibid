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
    @users = User.order(:created_at).page(params[:page])

    render 'users/index'
  end

  get :new do
    unless session[:auth]
      redirect url(:sessions, :new)
    end
    @user = User.new(session[:auth].slice(:name, :display_name))
    @user.authentications.build session[:auth].slice(:provider, :uid)
    session.delete :auth

    render 'users/new'
  end

  get :show, :map => '/users/:name' do
    @user = User.find_by_name(params[:name])
    if @user
      render 'users/show'
    else
      halt 404
    end
  end

  post :create, :map => '/users' do
    @user = User.new(params[:user].slice('name', 'display_name'))
    @user.authentications.build(params[:authentication])
    if @user.save
      session[:user_id] = @user.id
      redirect url(:users, :show, :name => @user.name), :success => I18n.t('notice.users.create')
    else
      render 'users/new'
    end
  end

  put :update, :map => '/users/:name', :require_sign_in => true do
    return halt 403 unless current_user.name == params[:name]
    @user = User.find_by_name(params[:name])
    if @user.update_attributes params[:user].slice('display_name')
      redirect url(:users, :show, :name => params[:name]), :success => I18n.t('notice.users.update')
    else
      render 'users/show'
    end
  end

  delete :destroy, :map => '/users/:name', :require_sign_in => true do
    return halt 403 unless current_user.name == params[:name]
    @user = User.find_by_name(params[:name])
    if @user.destroy
      redirect url(:root, :index), :success => I18n.t('notice.users.destroy')
    else
      render 'users/show'
    end
  end

end
