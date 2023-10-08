# frozen_string_literal: true

server 'risa', user: 'gd', roles: %w[app db web]
set :deploy_to, '/rails/eldac'
set :rails_env, 'production'

set :pty, true
set :ssh_options, {
  forward_agent: true,
  port: 2217
}
