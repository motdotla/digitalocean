require 'spec_helper'

describe Digitalocean::Domain do
  subject(:domain) { described_class }

  describe "._all" do
    let(:url) { domain._all }
    it { url.should eq "https://api.digitalocean.com/v1/domains?client_id=client_id_required&api_key=api_key_required" }
  end

  describe "._find" do
    let(:domain_id) { "1234" }
    let(:url) { domain._find(domain_id) }

    it { url.should eq "https://api.digitalocean.com/v1/domains/#{domain_id}?client_id=client_id_required&api_key=api_key_required" }
  end

  describe "._create" do
    let(:name)       { "test_domain" }
    let(:ip_address) { "test_ip_address" }
    let(:args)       { { name: name, ip_address: ip_address } }

    let(:url) { domain._create(args) }

    it { url.should eq "https://api.digitalocean.com/v1/domains/new?client_id=client_id_required&api_key=api_key_required&name=test_domain&ip_address=test_ip_address" }
  end

  describe "._destroy" do
    let(:domain_id) { "test_domain_id" }
    let(:url) { domain._destroy(domain_id) }

    it { url.should eq "https://api.digitalocean.com/v1/domains/test_domain_id/destroy?client_id=client_id_required&api_key=api_key_required" }
  end
end
