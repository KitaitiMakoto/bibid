#!/usr/bin/env rackup
# encoding: utf-8

# This file can be used to start Padrino,
# just execute it from the command line.

require File.expand_path("../config/boot.rb", __FILE__)

if ENV['RACK_ENV'] == 'production'
  run Padrino.application
else
  run Rack::Cascade.new([
    Rack::File.new('public'),
    Padrino.application,
    Rack::Static.new(Padrino.application, urls: ['/components'], root: 'public', index: 'index.html')
  ])
end
