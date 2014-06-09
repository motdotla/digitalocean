# Digitalocean Rubygem

![](https://raw.github.com/scottmotte/digitalocean/master/digitalocean-rubygem.jpg)

### The easiest and most complete rubygem for [DigitalOcean](https://www.digitalocean.com).

[![Build Status](https://travis-ci.org/scottmotte/digitalocean.svg?branch=master)](https://travis-ci.org/scottmotte/digitalocean)
[![Gem Version](https://badge.fury.io/rb/digitalocean.svg)](http://badge.fury.io/rb/digitalocean)

```ruby
Digitalocean.client_id  = "your_client_id"
Digitalocean.api_key    = "your_api_key"
result = Digitalocean::Droplet.all
# =>
# <RecursiveOpenStruct status="OK", droplets=[
#   {"id"=>12345, "name"=>"dev", "image_id"=>2676, "size_id"=>63, "region_id"=>3, "backups_active"=>false, "ip_address"=>"198.555.55.55", "private_ip_address"=>nil, "locked"=>false, "status"=>"active", "created_at"=>"2013-06-12T03:07:14Z"},
#   {"id"=>234674, "name"=>"server2", "image_id"=>441012, "size_id"=>62, "region_id"=>1, "backups_active"=>false, "ip_address"=>"192.555.55.56", "private_ip_address"=>nil, "locked"=>false, "status"=>"active", "created_at"=>"2013-06-17T00:30:12Z"}
# ]>
#

result.status
result.droplets
result.droplets.first.ip_address
```

## Installation

Add this line to your application's Gemfile:

```
gem 'digitalocean'
```

And then execute:

```
bundle
```

Or install it yourself as:

```
gem install digitalocean
```

Then in your application initialize the gem:

```ruby
Digitalocean.client_id  = "your_client_id"
Digitalocean.api_key    = "your_api_key"
```

You can find your keys at [https://cloud.digitalocean.com/api_access](https://cloud.digitalocean.com/api_access)

[![](https://raw2.github.com/scottmotte/digitalocean/master/example.png)](https://cloud.digitalocean.com/api_access)

## Usage

### List Droplets

```ruby
Digitalocean::Droplet.all
```

### Find Droplet

```ruby
Digitalocean::Droplet.find("id_of_droplet")
```

### Create Droplet

```ruby
Digitalocean::Droplet.create({:name => droplet_name, :size_id => size_id, :image_id => image_id, :region_id => region_id})
```
## Available Commands

```ruby
Digitalocean::Domain.all
Digitalocean::Domain.find(id)
Digitalocean::Domain.create({name: name, ip_address: ip_address})
Digitalocean::Domain.destroy(id)

Digitalocean::Droplet.all
Digitalocean::Droplet.find(id)
Digitalocean::Droplet.rename(id, {name: name})
Digitalocean::Droplet.reboot(id)
Digitalocean::Droplet.power_cycle(id)
Digitalocean::Droplet.shutdown(id)
Digitalocean::Droplet.power_off(id)
Digitalocean::Droplet.power_on(id)
Digitalocean::Droplet.snapshot(id, {name: name})
Digitalocean::Droplet.create({name: name, size_id: size_id, image_id: image_id, region_id: region_id, ssh_key_ids: ssh_key_ids})
Digitalocean::Droplet.destroy(id)
Digitalocean::Droplet.resize(id, {size_id: size_id})

Digitalocean::Image.all
Digitalocean::Image.all({filter: "my_images"})
Digitalocean::Image.find(id)
Digitalocean::Image.destroy(id)
Digitalocean::Image.transfer(id, {region_id: region_id})

Digitalocean::Record.all(domain_id)
Digitalocean::Record.find(domain_id, record_id)
Digitalocean::Record.create(domain_id, {record_type: record_type, data: data})
Digitalocean::Record.edit(domain_id, record_id, {record_type: record_type, data: data})
Digitalocean::Record.destroy(domain_id, record_id)

Digitalocean::Region.all
Digitalocean::Region.find(region_id)

Digitalocean::Size.all
Digitalocean::Size.find(size_id)

Digitalocean::SshKey.all
Digitalocean::SshKey.find(id)
Digitalocean::SshKey.create({name: name, ssh_pub_key: ssh_pub_key}) # Keep in mind you have to use CGI::escape for your ssh_pub_key

Digitalocean::Event.find(id)
```

## Example

There is a [digitalocean-rubygem-example](https://github.com/scottmotte/digitalocean-rubygem-example) to help jumpstart your development.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
5. Commit your changes (`git commit -am 'Add some feature'`)
6. Push to the branch (`git push origin my-new-feature`)
7. Create new Pull Request

When adding methods, add to the list of DEFINITIONS in `lib/digitalocean.rb`. Additionally, write a spec and add it to the list in the README.

## Running Specs

```
bundle exec rspec spec/*
```

## Publish to RubyGems.org

You first need to request access from [scottmotte](http://github.com/scottmotte).

```
gem build digitalocean.gemspec
gem push digitalocean-1.0.1.gem
```
