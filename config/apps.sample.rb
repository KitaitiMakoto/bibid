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

##
# Setup global project settings for your apps. These settings are inherited by every subapp. You can
# override these settings in the subapps as needed.
#
Padrino.configure_apps do
  enable :sessions
  raise "Configure session_secret such like '01b730daf02343fb470231c6a1f4db8e8c0b755e48c5b2fb2659c65065f69011'"
  set :session_secret, 'Determine session secret and write here'
  set :protection, true
  set :protect_from_csrf, true
  set :total_file_size_limit, 20.megabytes
end

TWITTER_CONSUMER_KEY = raise 'Twitter consumer key here'
TWITTER_CONSUMER_SECRET = raise 'Twitter consumer secret here'
FACEBOOK_APP_ID = raise 'Facebook App ID here'
FACEBOOK_APP_SECRET = raise 'Facebook App secret here'

raise "Configure EpubUploader.salt such like 'urfnc09d817ioda900e9023d9557f232u91e'"
EpubUploader.salt = 'Determine random letters and write here'

# Mounts the core application for this project
Padrino.mount('Bibid::App', :app_file => Padrino.root('app/app.rb')).to('/')
