set :application, 'oris'
set :deploy_user, 'deployer'

# setup repo details
set :scm, :git
set :repo_url, 'git@github.com:yasinishyn/oris-1.git'

# how many old releases do we want to keep, not much
set :keep_releases, 5

# files we want symlinking to specific entries in shared
set(:linked_files, %w(
  config/database.yml
  puma.rb
  config/secrets.yml
  config/application.yml
))

set(:linked_dirs, %w(
  bin
  log
  tmp/pids
  tmp/cache
  tmp/sockets
  vendor/bundle
  public/system
  public/uploads
))

set(:config_files, %w(
  nginx.conf
  database.example.yml
  log_rotation
))

set :ssh_options, port: 136_66,
                  forward_agent: true,
                  user: fetch(:user),
                  keys: %w(~/.ssh/id_rsa.pub)

set(:symlinks, [
  {
    source: 'nginx.conf',
    link: '/etc/nginx/sites-enabled/{{full_app_name}}'
  }, {
    source: 'log_rotation',
    link: '/etc/logrotate.d/{{full_app_name}}'
  }
])

# puma settings
set :puma_init_active_record, true

# Don't change these unless you know what you're doing
set :pty,        true
set :use_sudo,   false
set :deploy_via, :remote_cache

namespace :deploy do
  # make sure we're deploying what we think we're deploying
  before :deploy, 'deploy:check_revision'
  # only allow a deploy with passing tests to deployed
  # before :deploy, "deploy:run_tests"
  # compile assets locally then rsync
  after 'deploy:symlink:shared', 'deploy:compile_assets_locally'
  after :finishing, 'deploy:cleanup'

  # remove the default nginx configuration as it will tend
  # to conflict with our configs.
  before 'deploy:setup_config', 'nginx:remove_default_vhost'

  # reload nginx to it will pick up any modified vhosts from
  # setup_config
  after 'deploy:setup_config', 'nginx:reload'

  # Restart monit so it will pick up any monit configurations
  # we've added
  # after 'deploy:setup_config', 'monit:restart'

  # As of Capistrano 3.1, the `deploy:restart` task is not called
  # automatically.
  after 'deploy:publishing', 'deploy:restart'
end
