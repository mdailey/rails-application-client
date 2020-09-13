# RailsApplicationClient

Edge computation architectures typically comprise a set
of compute resources that are integrated with or physically
proximate with sensors and actuators and a cloud-based
application that centrally collects events and provides
dashboard functionality to users.

When the central Web application / dashboard application is
a Rails application, we end up with a recurring problem, the
answer to these questions:
 
  - How to configure a server to accept incoming event streams
    from multiple computational clients?
  - How to secure the privacy, integrity, and authenticity of the
    communication between the server and each client?

This problem is already addressed in the SSL/TLS protocols.
We configure the Web application as a Web service endpoint
and protect the communication with SSL/TLS and mutual authentication
with X.509 certificates. The server acts as a central certificate
authority that issues certificates for each client. To add a new
client, the administrator provides some information about the new
client, downloads the new client's SSL private key and client
certificate, and installs the key/certificate files on the client.
Thereafter, the client software uses the the key and certificate to
establish a secure authenticated connection with the server and
upload its event stream.

This gem provides scaffolding to manage edge computing clients of a
Rails application. It provides ActiveRecord models for the server
configuration (CA key and certificate) and clients (description,
key, and certificate), as well as appropriate controllers and views.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rails-application-client'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install rails-application-client

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mdailey/rails-application-client. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/mdailey/rails-application-client/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the RailsApplicationClient project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/mdailey/rails-application-client/blob/master/CODE_OF_CONDUCT.md).
