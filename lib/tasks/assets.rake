require 'rake/sprocketstask'

desc 'Compile assets'
task :assets => 'assets:default'

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
end
