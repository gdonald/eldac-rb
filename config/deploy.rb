# frozen_string_literal: true

lock '~> 3.17.3'

set :application, 'eldac'
set :repo_url, 'git@github.com:gdonald/eldac-rb.git'
set :branch, 'main'

append :linked_files, 'config/database.yml', 'config/secrets.yml', 'config/storage.yml'
append :linked_dirs, 'storage', 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system'
set :passenger_restart_with_touch, true
