Bibid::App.helpers do
  def sign_in_url
    settings.omniauth_providers.length == 1 ?
      "/auth/#{settings.omniauth_providers.first.first}" :
      url(:sessions, :new)
  end
end
