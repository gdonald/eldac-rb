
## Welcome to Eldac

Eldac is an ELectronic DAta Capture tool.

## Getting Started

1. Copy database settings example:

		$ cp config/database.yml-example config/database.yml

2. Install gems:

		$ bundle install

3. Migrate database:

		bundle exec rake db:setup

4. Run tests:

		bundle exec rake

5. Run:

		$ bundle exec rails s

6. Open [http://localhost:3000](http://localhost:3000).

		w0oh0o! :)

## Status

[![Build Status](https://travis-ci.org/gdonald/eldac.svg?branch=master)](https://travis-ci.org/gdonald/eldac)

## License

Eldac is released under the [MIT License](http://www.opensource.org/licenses/MIT)
