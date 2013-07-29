# Helper methods defined here can be accessed in any controller or view in the application

Bibid::App.helpers do
  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end
end
