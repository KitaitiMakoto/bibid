#!/usr/bin/env rackup
# encoding: utf-8

# This file can be used to start Padrino,
# just execute it from the command line.

require File.expand_path("../config/boot.rb", __FILE__)

if ENV['RACK_ENV'] == 'production'
  run Padrino.application
else
  use Rack::Static, :urls => ['/components'], :root => 'public', :index => 'index.html'
  run Rack::Cascade.new([
    Rack::File.new('public'),
    Padrino.application
  ])
end
