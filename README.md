# Rack::Nojs

treat script tag in response.body when access with old mobile phone.

## Installation

Add this line to your application's Gemfile:

    gem 'rack-nojs'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rack-nojs

## Usage

### Rails2

Insert follow code into your config/environment.rb

    require 'rack-nojs'
    config.middleware.use ::Rack::Nojs

### Rails3

You don't need this gem :)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
