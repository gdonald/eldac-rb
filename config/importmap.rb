# frozen_string_literal: true

# Pin npm packages by running ./bin/importmap

pin 'jquery', to: 'jquery3.min.js', preload: true
pin 'jquery-ujs', to: 'jquery-ujs.js', preload: true
pin '@popperjs/core', to: 'popper.js', preload: true
pin 'select2', to: 'select2.min.js', preload: true

pin 'application', preload: true
pin '@hotwired/turbo-rails', to: 'turbo.min.js', preload: true
pin '@hotwired/stimulus', to: 'stimulus.min.js', preload: true
pin '@hotwired/stimulus-loading', to: 'stimulus-loading.js', preload: true
pin_all_from 'app/javascript/controllers', under: 'controllers'

