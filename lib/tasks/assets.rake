require 'rake/sprocketstask'

desc 'Compile assets'
task :assets => 'assets:default'

HTML_ASSET_DIR = './app/elements'

namespace :assets do
  task :default => %w[stylesheets strip_digest_stylesheets javascripts strip_digest_javascripts]

  %w[stylesheets javascripts].each do |type|
    output = "./public/#{type}"
    ext = case type
          when 'stylesheets' then '.css'
          when 'javascripts' then '.js'
          end
    Rake::SprocketsTask.new type do |t|
      t.environment = Sprockets::Environment.new
      t.environment.append_path File.join('app', type)
      t.output = output
      t.assets = ["application#{ext}"]
    end

    desc 'Strip digest from asset file name'
    task "strip_digest_#{type}" do
      mv Dir["#{output}/application-*#{ext}"].first, "#{output}/application#{ext}"
    end
  end

  desc 'Copy HTML to public directory'
  task :html do
    Dir["#{HTML_ASSET_DIR}/**/*.html"].each do |path|
      dest = path.sub(/\/app\//, '/public/')
      dirname = File.dirname(dest)
      mkpath dirname unless File.exist? dirname
      cp path, dest
    end
  end

  desc 'Vulcanize HTML to import'
  task :vulcanize do
    sh 'vulcanize ./public/elements/elements.html --abspath=./public/ --output=./public/elements/elements.html'
  end
end
