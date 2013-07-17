Bibid::App.controllers :sessions do
  
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
  
  get :new do
    render 'sessions/new'
  end

  get :create, :map => '/auth/:provider/callback' do
    auth = request.env['omniauth.auth']
    unless auth.provider == params[:provider]
      raise
    end
    authentication = Authentication.find_by_provider_and_uid(auth.provider, auth.uid)
    if authentication
      session[:user_id] = authentication.user.id
      redirect url(:users, :show, :name => current_user.name)
    elsif current_user
      current_user.authentications.create provider: auth.provider, uid: auth.uid
      redirect url(:users, :show, :name => current_user.name)
    else
      session[:auth] = {
        :provider     => auth.provider,
        :uid          => auth.uid,
        :name         => Authentication.name_from(auth),
        :display_name => Authentication.display_name_from(auth)
      }
      redirect url(:users, :new)
    end
  end

  delete :destroy, :map => '/session', :require_sign_in => true do
    session.clear
    redirect '/'
  end
end
