
# require 'capistrano/chruby'
require 'capistrano/setup'
require 'capistrano/deploy'
require 'capistrano/rails'
# Includes asset handling
require 'capistrano/rails/assets'
require 'capistrano/puma'


require 'capistrano/rbenv'
require 'capistrano/bundler'
# require 'capistrano/rvm'

# Loads custom tasks from `lib/capistrano/tasks' if you have any defined.
Dir.glob('lib/capistrano/tasks/*.cap').each { |r| import r }
Dir.glob('lib/capistrano/**/*.rb').each { |r| import r }
