module Bibid
  class App < Padrino::Application
    use HttpAcceptLanguage::Middleware
    register Padrino::Rendering
    register Padrino::Mailer
    register Padrino::Helpers
    register Kaminari::Helpers::SinatraHelpers

    OmniAuth.config.on_failure do |env|
      OmniAuth::FailureEndpoint.new(env).redirect_to_failure
    end
    use OmniAuth::Builder do
      Bibid::App.settings.omniauth_providers.each do |properties|
        provider *properties
      end
    end

    class << self
      def require_sign_in(*args)
        condition do
          halt 403, 'Signing in required' unless current_user
        end
      end
    end

    ##
    # Caching support
    #
    # register Padrino::Cache
    # enable :caching
    #
    # You can customize caching store engines:
    #
    # set :cache, Padrino::Cache::Store::Memcache.new(::Memcached.new('127.0.0.1:11211', :exception_retry_limit => 1))
    # set :cache, Padrino::Cache::Store::Memcache.new(::Dalli::Client.new('127.0.0.1:11211', :exception_retry_limit => 1))
    # set :cache, Padrino::Cache::Store::Redis.new(::Redis.new(:host => '127.0.0.1', :port => 6379, :db => 0))
    # set :cache, Padrino::Cache::Store::Memory.new(50)
    # set :cache, Padrino::Cache::Store::File.new(Padrino.root('tmp', app_name.to_s, 'cache')) # default choice
    #

    ##
    # Application configuration options
    #
    # set :raise_errors, true       # Raise exceptions (will stop application) (default for test)
    # set :dump_errors, true        # Exception backtraces are written to STDERR (default for production/development)
    # set :show_exceptions, true    # Shows a stack trace in browser (default for development)
    # set :logging, true            # Logging in STDOUT for development and file for production (default only for development)
    # set :public_folder, 'foo/bar' # Location for static assets (default root/public)
    # set :reload, false            # Reload application files (default in development)
    # set :default_builder, 'foo'   # Set a custom form builder (default 'StandardFormBuilder')
    # set :locale_path, 'bar'       # Set path for I18n translations (default your_apps_root_path/locale)
    # disable :sessions             # Disabled sessions by default (enable if needed)
    # disable :flash                # Disables sinatra-flash (enabled by default if Sinatra::Flash is defined)
    # layout  :my_layout            # Layout can be in views/layouts/foo.ext or views/foo.ext (default :application)
    #

    ##
    # You can configure for a specified environment like:
    #
    #   configure :development do
    #     set :foo, :bar
    #     disable :asset_stamp # no asset timestamping for dev
    #   end
    #

    before do
      I18n.locale = request.env.http_accept_language.compatible_language_from(settings.available_languages) || I18n.default_locale
      response.header['Content-Language'] = I18n.locale.to_s
      varies = response.header['Vary'].to_s.split(/\s*,\s*/)
      varies << 'Accept-Language' unless varies.include?('Accept-Language')
      response.header['Vary'] = varies.join(',')
    end

    not_found do
      render 'errors/404'
    end

    ##
    # You can manage errors like:
    #
    error 404 do
      render 'errors/404'
    end

    error 403 do
      '403 Forbidden'
    end

    # error 505 do
    #   render 'errors/505'
    # end

    get '/' do
      render 'home/index'
    end

    get '/auth/failure' do
      redirect url(:sessions, :new), :error => I18n.t('notice.sessions.error', :strategy => params['strategy'], :message => params['message'])
    end
  end
end
