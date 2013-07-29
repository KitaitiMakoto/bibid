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
  set :avalable_languages, ['en', 'ja']
  set :total_file_size_limit, 20.megabytes
  set :epub_uploader_salt, raise "Configure EpubUploader.salt such like 'urfnc09d817ioda900e9023d9557f232u91e'"
  set :google_oauth2_client_id, raise 'Google OAuth client id here'
  set :google_oauth2_client_secret, raise 'Google OAuth client secret here'
  set :twitter_consumer_key, raise 'Twitter consumer key here'
  set :twitter_consumer_secret, raise 'Twitter consumer secret here'
  set :facebook_app_id, raise 'Facebook App ID here'
  set :facebook_app_secret, raise 'Facebook App secret here'
end

# Mounts the core application for this project
Padrino.mount('Bibid::App', :app_file => Padrino.root('app/app.rb')).to('/')
