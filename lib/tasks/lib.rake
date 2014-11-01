desc 'Update dependent packages'
task :lib => 'lib:default'

namespace :lib do
  task :default => %w[gem:default bower:default]

  desc 'Update RubyGems'
  task :gem => 'gem:update'

  desc 'Update bower packages'
  task :bower => 'bower:update'

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
    task :default => [:update, :prune]

    desc 'Install bower packages'
    task :install do
      sh 'bower install'
    end

    desc 'Update bower packages'
    task :update do
      sh 'bower update'
    end

    desc 'Prune bower packages'
    task :prune do
      sh 'bower prune'
    end
  end
end
