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

  get :show, :map => '/users/:name', :provides => %i[html opds rss] do
    @user = User.find_by_name(params[:name])
    if @user
      case content_type
      when :opds
        opds_from_user(@user).to_s
      when :rss
        rss_from_user(@user).to_s
      else
        render 'users/show'
      end
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

  put :update, :map => '/users/:name', :require_sign_in => true, :provides => %i[html json] do
    return halt 403 unless current_user.name == params[:name]
    @user = User.find_by_name(params[:name])
    user_param =
      request.media_type == 'application/json' ?
        JSON.parse(request.body.read) :
        params[:user]
    if @user.update_attributes user_param.slice('display_name')
      if request.xhr?
        response.status = 204
        ''
      else
        redirect url(:users, :show, :name => params[:name]), :success => I18n.t('notice.users.update')
      end
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
