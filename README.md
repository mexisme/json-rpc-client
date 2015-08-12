# JsonRpc

This is a simple JSON-RPC client, using Faraday & Typhoeus (by default).

Why Faraday?  Because it abstracts several other network-api's successfully, and allows a Rack-like middleware layer,
which allows automatic data-conversion, error-handling, logging, etc.

Currently, we only use the middleware for encode/decode data to JSON, but the plan is convert this to a Faraday
middleware in the near-term (see `TODO.org`) -- the rough framework for this is already there.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'jsonrpc-faraday'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install jsonrpc-faraday

## Usage


### Example

Create a new RPC connection, connect to https://rpc.domain.somewhere, with a call-back that will prefix the auth token
to the head of the arg-list for every RPC call to the remote server:

```ruby
require "jsonrpc"

rpc = JsonRpc::Client.connect("https://rpc.domain.somewhere") {|args| ["authorisation token"] + args }
rpc.call("method", :a, :b, :c)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mexisme/jsonrpc-faraday. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.
