# -*- coding: utf-8 -*-
# Defines our constants
RACK_ENV  = ENV['RACK_ENV'] ||= 'development'  unless defined?(RACK_ENV)
PADRINO_ROOT = File.expand_path('../..', __FILE__) unless defined?(PADRINO_ROOT)

# Load our dependencies
require 'rubygems' unless defined?(Gem)
require 'bundler/setup'
Bundler.require(:default, RACK_ENV)
require "google/api_client" # To prevent loading "google/api_client/railtie"

##
# ## Enable devel logging
#
# Padrino::Logger::Config[:development][:log_level]  = :devel
# Padrino::Logger::Config[:development][:log_static] = true
#
# ## Configure your I18n
#
# I18n.default_locale = :en
I18n.default_locale = :ja
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
require 'action_view/helpers'
require 'action_view/helpers/number_helper'
require 'action_dispatch/http/mime_type'

##
# Add your before (RE)load hooks here
#
Padrino.before_load do
  Padrino::Application.prerequisites << Padrino.root("app/uploaders/**/*.rb")
end

##
# Add your after (RE)load hooks here
#
Padrino.after_load do
  ActiveRecord::Base.send :include, Padrino::Helpers::NumberHelpers
end

CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+？]/
CarrierWave.configure do |config|
  if ENV["CARRIERWAVE_FOG_PROVIDER"]
    require "carrierwave/storage/fog"

    config.storage = :fog

    case ENV["CARRIERWAVE_FOG_PROVIDER"]
    when "google"
      config.fog_provider = 'fog/google'
      config.fog_directory = (ENV["CARRIERWAVE_FOG_DIRECTORY"] || raise("CARRIERWAVE_FOG_DIRECTORY not set"))
      config.fog_credentials = {
        provider: "Google",
        google_project: (ENV["CARRIERWAVE_FOG_PROJECT"] || raise("CARRIERWAVE_FOG_PROJECT not set")),
        google_json_key_location: (ENV["CARRIERWAVE_FOG_KEY_LOCATION"] || raise("CARRIERWAVE_FOG_KEY_LOCATION not set"))
      }
    else
      raise "Unsupported CarrierWave provider #{ENV['CARRIERWAVE_FOG_PROVIDER']}"
    end
  else
    config.storage = :file
  end
end

EPUB::OCF::PhysicalContainer.adapter = :Zipruby

Padrino.load!
