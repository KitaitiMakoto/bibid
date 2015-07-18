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
  set :session_secret, raise "Configure session_secret such like '01b730daf02343fb470231c6a1f4db8e8c0b755e48c5b2fb2659c65065f69011'"
  set :protection, true
  set :protect_from_csrf, true
  set :available_languages, ['en', 'ja']
  set :total_file_size_limit, 20 * 1024 * 1024
  set :epub_uploader_salt, raise "Configure EpubUploader.salt such like 'urfnc09d817ioda900e9023d9557f232u91e'"
  set :sandbox_retention_count, 12
  set :sandbox_retention_time, 1 * 60 * 60
  set :sandbox_file_size_limit, 6 * 1024 * 1024
  set :html_asset_folder, 'elements'
  set :omniauth_providers, raise [
    # You may comment out proviers which you don't support
    [:google_oauth2, 'Google OAuth client id here', 'Google OAuth client secret here'],
    [:twitter, 'Twitter consumer key here', 'Twitter consumer secret here'],
    [:facebook, 'Facebook App ID here', 'Facebook App secret here']
  ]
  # set :google_analytics_tag, 'Google Analytics tag here'
  set :contact, raise 'Contact URI here'

  mime_type :opds, RSS::OPDS::TYPES['navigation']
end

# Mounts the core application for this project
Padrino.mount('Bibid::App', :app_file => Padrino.root('app/app.rb')).to('/')
