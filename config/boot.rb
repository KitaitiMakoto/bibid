# -*- coding: utf-8 -*-
# Defines our constants
PADRINO_ENV  = ENV['PADRINO_ENV'] ||= ENV['RACK_ENV'] ||= 'development'  unless defined?(PADRINO_ENV)
PADRINO_ROOT = File.expand_path('../..', __FILE__) unless defined?(PADRINO_ROOT)

# Load our dependencies
require 'rubygems' unless defined?(Gem)
require 'bundler/setup'
Bundler.require(:default, PADRINO_ENV)

##
# ## Enable devel logging
#
# Padrino::Logger::Config[:development][:log_level]  = :devel
# Padrino::Logger::Config[:development][:log_static] = true
#
# ## Configure your I18n
#
# I18n.default_locale = :en
#
# ## Configure your HTML5 data helpers
#
# Padrino::Helpers::TagHelpers::DATA_ATTRIBUTES.push(:dialog)
# text_field :foo, :dialog => true
# Generates: <input type="text" data-dialog="true" name="foo" />
#
# ## Add helpers to mailer
#
# Mail::Message.class_eval do
#   include Padrino::Helpers::NumberHelpers
#   include Padrino::Helpers::TranslationHelpers
# end
require 'digest/sha1'

##
# Add your before (RE)load hooks here
#
Padrino.before_load do
end

##
# Add your after (RE)load hooks here
#
Padrino.after_load do
  Foreigner.load
end

Dotenv.load! ".env.#{ENV['RACK_ENV']}"

# Restore behavior changed by padrino-sprockets
# TODO: Stop to use padrino-sprockets
module Padrino::Sprockets::Helpers::AssetTagHelpers
  def asset_folder_name(kind)
    case kind
    when :css then 'stylesheets'
    when :js  then 'javascripts'
    else kind.to_s
    end
  end
end

CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+？]/

Padrino.load!
