#!/usr/bin/env rackup
# encoding: utf-8

# This file can be used to start Padrino,
# just execute it from the command line.

require File.expand_path("../config/boot.rb", __FILE__)

%w[stylesheets javascripts].each do |type|
  environment = Sprockets::Environment.new
  environment.append_path Padrino.root('app', type)
  map "/#{type}" do
    run environment
  end
end

map "/components/bibi/bib/bookshelf" do
  run Rack::Archive::Zip::Extract.new('public/components/bibi/bib/bookshelf', extensions: %w[.epub])
end

map "/components" do
  use Rack::Static, :urls => {"/" => "index.html"}, :root => "public/components", :index => "index.html"
  run Rack::Directory.new("public/components")
end

run Padrino.application
