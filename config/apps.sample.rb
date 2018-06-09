##
# This file mounts each app in the Padrino project to a specified sub-uri.
# You can mount additional applications using any of these commands below:
#
#   Padrino.mount('blog').to('/blog')
#   Padrino.mount('blog', :app_class => 'BlogApp').to('/blog')
#   Padrino.mount('blog', :app_file =>  'path/to/blog/app.rb').to('/blog')
#
# You can also map apps to a specified host:
#
#   Padrino.mount('Admin').host('admin.example.org')
#   Padrino.mount('WebSite').host(/.*\.?example.org/)
#   Padrino.mount('Foo').to('/foo').host('bar.example.org')
#
# Note 1: Mounted apps (by default) should be placed into the project root at '/app_name'.
# Note 2: If you use the host matching remember to respect the order of the rules.
#
# By default, this file mounts the primary app which was generated with this project.
# However, the mounted app can be modified as needed:
#
#   Padrino.mount('AppName', :app_file => 'path/to/file', :app_class => 'BlogApp').to('/')
#

Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

##
# Setup global project settings for your apps. These settings are inherited by every subapp. You can
# override these settings in the subapps as needed.
#
Padrino.configure_apps do
  enable :sessions
  set :session_secret, ENV["SESSION_SECRET"] || raise("Environment variable SESSION_SECRET not set")
  set :protection, true
  set :protect_from_csrf, true
  set :available_languages, ['en', 'ja']
  set :total_file_size_limit, 20 * 1024 * 1024

  omniauth_providers = []
  %i[google_oauth2 twitter facebook].each do |provider|
    key_name = "#{provider.upcase}_KEY"
    secret_name = "#{provider.upcase}_SECRET"
    if ENV[key_name]
      if ENV[secret_name]
        omniauth_providers << [provider, ENV[key_name], ENV[secret_name]]
      else
        raise "Environment variable #{key_name} is set but #{secret_name} is not set"
      end
    end
  end
  set :omniauth_providers, omniauth_providers
  set :google_analytics_tag, nil # 'Google Analytics tag here'
  set :contact, ENV["CONTACT_URI"]

  if ENV["COMPONENTS_HOST_PROVIDER"]
    case ENV["COMPONENTS_HOST_PROVIDER"]
    when "google"
      set :components_host_params, {
        provider: "Google",
        google_project: (ENV["COMPONENTS_HOST_PROJECT"] || raise("COMPONENTS_HOST_PROJECT not set")),
        google_json_key_location: (ENV["COMPONENTS_HOST_KEY_LOCATION"] || raise("COMPONENTS_HOST_KEY_LOCATION not set"))
      }
      set :components_host_directory, (ENV["COMPONENTS_HOST_DIRECTORY"] || raise("COMPONENTS_HOST_DIRECTORY not set"))
      set :bibi_uri, "https://storage.googleapis.com/#{settings.components_host_directory}/components/bib/i/"
    else
      raise "COMPONENTS_HOST_PROVIDER #{ENV['COMPONENTS_HOST_PROVIDER']} not supported"
    end
  else
    set :bibi_uri, "/components/bibi/bib/i/"
  end

  mime_type :opds, RSS::OPDS::TYPES['navigation']
end

# Mounts the core application for this project
Padrino.mount('Bibid::App', :app_file => Padrino.root('app/app.rb')).to('/')
