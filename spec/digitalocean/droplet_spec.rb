require 'spec_helper'

describe Digitalocean::Droplet do
  subject(:droplet) { described_class }

  describe "._all" do
    let(:url) { droplet._all }
    it { url.should eq "https://api.digitalocean.com/v1/droplets/?client_id=client_id_required&api_key=api_key_required" }
  end

  describe "._find" do
    let(:droplet_id) { "1234" }
    let(:url) { droplet._find(droplet_id) }

    it { url.should eq "https://api.digitalocean.com/v1/droplets/#{droplet_id}?client_id=client_id_required&api_key=api_key_required" }
  end

  describe "._rename" do
    let(:droplet_id) { "1234" }
    let(:name) { "new_name" }
    let(:url) { droplet._rename(droplet_id, {name: name}) }

    it { url.should eq "https://api.digitalocean.com/v1/droplets/#{droplet_id}/rename/?client_id=client_id_required&api_key=api_key_required&name=#{name}" }
  end

  describe "._rebuild" do
    let(:droplet_id) { "1234" }
    let(:image_id)  { "11" }

    let(:url) { droplet._rebuild(droplet_id, {image_id: image_id}) }

    it { url.should eq "https://api.digitalocean.com/v1/droplets/#{droplet_id}/rebuild/?image_id=#{image_id}&client_id=client_id_required&api_key=api_key_required" }
  end

  describe "._reboot" do
    let(:droplet_id) { "1234" }
    let(:url) { droplet._reboot(droplet_id) }

    it { url.should eq "https://api.digitalocean.com/v1/droplets/#{droplet_id}/reboot/?client_id=client_id_required&api_key=api_key_required" }
  end

  describe "._power_cycle" do
    let(:droplet_id) { "1234" }
    let(:url) { droplet._power_cycle(droplet_id) }

    it { url.should eq "https://api.digitalocean.com/v1/droplets/#{droplet_id}/power_cycle/?client_id=client_id_required&api_key=api_key_required" }
  end

  describe "._shutdown" do
    let(:droplet_id) { "1234" }
    let(:url) { droplet._shutdown(droplet_id) }

    it { url.should eq "https://api.digitalocean.com/v1/droplets/#{droplet_id}/shutdown/?client_id=client_id_required&api_key=api_key_required" }
  end

  describe "._power_off" do
    let(:droplet_id) { "1234" }
    let(:url) { droplet._power_off(droplet_id) }

    it { url.should eq "https://api.digitalocean.com/v1/droplets/#{droplet_id}/power_off/?client_id=client_id_required&api_key=api_key_required" }
  end

  describe "._power_on" do
    let(:droplet_id) { "1234" }
    let(:url) { droplet._power_on(droplet_id) }

    it { url.should eq "https://api.digitalocean.com/v1/droplets/#{droplet_id}/power_on/?client_id=client_id_required&api_key=api_key_required" }
  end

  describe "._snapshot" do
    let(:droplet_id) { "1234" }
    let(:snapshot_name) { "test_name" }

    let(:url) { droplet._snapshot(droplet_id, {name: snapshot_name}) }

    it { url.should eq "https://api.digitalocean.com/v1/droplets/#{droplet_id}/snapshot/?name=#{snapshot_name}&client_id=client_id_required&api_key=api_key_required" }
  end

  describe "._create" do
    let(:name)      { "test_name" }
    let(:size_id)   { "1234" }
    let(:image_id)  { "11" }
    let(:region_id) { "44" }
    let(:ssh_key_ids) { "12,92" }

    let(:url) { droplet._create({name: name, size_id: size_id, image_id: image_id, region_id: region_id, ssh_key_ids: ssh_key_ids}) }

    it { url.should eq "https://api.digitalocean.com/v1/droplets/new?client_id=client_id_required&api_key=api_key_required&name=#{name}&size_id=#{size_id}&image_id=#{image_id}&region_id=#{region_id}&ssh_key_ids=#{ssh_key_ids}&private_networking=private_networking&backups_enabled=backups_enabled" }
  end

  describe "._destroy" do
    let(:droplet_id) { "1234" }
    let(:url) { droplet._destroy(droplet_id) }

    it { url.should eq "https://api.digitalocean.com/v1/droplets/#{droplet_id}/destroy/?client_id=client_id_required&api_key=api_key_required" }
  end

  describe "._resize" do
    let(:droplet_id) { "1234" }
    let(:size_id) { "45" }

    let(:url) { droplet._resize(droplet_id, {size_id: size_id}) }

    it { url.should eq "https://api.digitalocean.com/v1/droplets/#{droplet_id}/resize/?size_id=#{size_id}&client_id=client_id_required&api_key=api_key_required" }
  end
end
