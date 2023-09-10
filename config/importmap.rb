# frozen_string_literal: true

# Pin npm packages by running ./bin/importmap

pin 'application', preload: true
pin '@hotwired/turbo-rails', to: 'turbo.min.js', preload: true
pin '@hotwired/stimulus', to: 'stimulus.min.js', preload: true
pin '@hotwired/stimulus-loading', to: 'stimulus-loading.js', preload: true
pin_all_from 'app/javascript/controllers', under: 'controllers'

# pin 'jquery', to: 'jquery3.min.js', preload: true
# pin 'jquery-ujs', to: 'jquery-ujs.js', preload: true
# pin '@popperjs/core', to: 'popper.js', preload: true
# pin 'select2', to: 'select2.min.js', preload: true

pin 'jquery', to: 'https://ga.jspm.io/npm:jquery@3.6.0/dist/jquery.js', preload: true
pin 'select2', to: 'https://cdn.jsdelivr.net/npm/select2@4.1.13/dist/js/select2.min.js'
