# SwaggerHubApiPusher

[![Gem Version](https://badge.fury.io/rb/swagger_hub_api_pusher.svg)](https://badge.fury.io/rb/swagger_hub_api_pusher)
[![Build Status](https://travis-ci.org/trickstersio/swagger_hub_api_pusher.svg?branch=master)](https://travis-ci.org/trickstersio/swagger_hub_api_pusher)

Provides rake task for pushing swagger.json to SwaggerHub API

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'swagger_hub_api_pusher'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install swagger_hub_api_pusher

## Usage

Run the install generator:

    $ rails generate swagger_hub_api_pusher:install

It will create `config/initializers/swagger_hub_api_pusher.rb` (add your settings from SwaggerHub API).

Run rake task for push you `swagger.json` to SwaggerHub:

    $ rake swagger:push


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/trickstersio/swagger_hub_api_pusher.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
