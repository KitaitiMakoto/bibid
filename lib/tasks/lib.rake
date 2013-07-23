desc 'Update dependent packages'
task :lib => 'lib:default'

namespace :lib do
  task :default => %w[gem:default bower:default]

  namespace :gem do
    task :default => :update

    desc 'Install RubyGems'
    task :install do
      sh 'bundle install --path=deps'
    end

    desc 'Update RubyGems'
    task :update do
      sh 'bundle update'
    end
  end

  namespace :bower do
    task :default => :update

    desc 'Install bower packages'
    task :install do
      sh 'bower install'
    end

    desc 'Update bower packages'
    task :update do
      sh 'bower update'
    end
  end
end
