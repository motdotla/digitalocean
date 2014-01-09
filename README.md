# Digitalocean Ruby Bindings

This gem is a wrapper for [DigitalOcean.com](https://www.digitalocean.com)'s API.

## Installation

Add this line to your application's Gemfile:

    gem 'digitalocean'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install digitalocean

Then in your application initialize the gem:

    $ Digitalocean.client_id  = "your_client_id"
    $ Digitalocean.api_key    = "your_api_key"

## Usage

### List Droplets

    $ Digitalocean::Droplet.all

### Retrieve Droplet

    $ Digitalocean::Droplet.retrieve("id_of_droplet")

### Create Droplet

    $ Digitalocean::Droplet.create({:name => droplet_name, :size_id => size_id, :image_id => image_id, :region_id => region_id)

## Available Commands

    $ Digitalocean::Droplet.all
    $ Digitalocean::Droplet.retrieve(id)
    $ Digitalocean::Droplet.create({})
    $ Digitalocean::Droplet.reboot(id)
    $ Digitalocean::Droplet.power_cycle(id)
    $ Digitalocean::Droplet.shut_down(id)
    $ Digitalocean::Droplet.power_off(id)
    $ Digitalocean::Droplet.power_on(id)
    $ Digitalocean::Droplet.snapshot(id)
    $ Digitalocean::Droplet.destroy(id)

    $ Digitalocean::Image.all
    $ Digitalocean::Image.find(id)
    $ Digitalocean::Image.destroy(id)
    $ Digitalocean::Image.transfer(id, region_id)

    $ Digitalocean::Region.all

    $ Digitalocean::Size.all

    $ Digitalocean::SshKey.all
    $ Digitalocean::SshKey.retrieve(id)
    $ Digitalocean::SshKey.create({})

    $ Digitalocean::Domain.all
    $ Digitalocean::Domain.find(id)
    $ Digitalocean::Domain.create(domain_name, ip_address)
    $ Digitalocean::Domain.destroy(id)

    $ Digitalocean::Record.all(domain_id)
    $ Digitalocean::Record.find(domain_id, record_id)
    $ Digitalocean::Record.create(domain_id, record_type, data, [name, priority, port, weight])
    $ Digitalocean::Record.edit(domain_id, record_id, {})
    $ Digitalocean::Record.destroy(domain_id, record_id)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
5. Commit your changes (`git commit -am 'Add some feature'`)
6. Push to the branch (`git push origin my-new-feature`)
7. Create new Pull Request

## Running Specs

1. cp .env-example .env
2. Set your credentials in the .env file
3. bundle exec foreman run bundle exec rspec spec/digitalocean/*
