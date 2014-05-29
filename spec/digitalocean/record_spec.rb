require 'spec_helper'

describe Digitalocean::Record do
  subject(:record) { described_class }

  describe "._all" do
    let(:domain_id) { "100" }
    let(:url) { record._all(domain_id) }

    it { url.should eq "https://api.digitalocean.com/v1/domains/#{domain_id}/records?client_id=client_id_required&api_key=api_key_required" }
  end

  describe "._find" do
    let(:domain_id) { "100" }
    let(:record_id) { "50" }

    let(:url) { record._find(domain_id, record_id) }

    it { url.should eq "https://api.digitalocean.com/v1/domains/#{domain_id}/records/#{record_id}?client_id=client_id_required&api_key=api_key_required" }
  end

  describe "._create" do
    let(:domain_id)   { "100" }
    let(:record_type) { "A" }
    let(:data)        { "@" }
    let(:attrs) { {record_type: record_type, data: data } }

    let(:url) { record._create(domain_id, attrs) }

    it { url.should eq "https://api.digitalocean.com/v1/domains/#{domain_id}/records/new?client_id=client_id_required&api_key=api_key_required&record_type=#{record_type}&data=#{data}" }
  end

  describe "._edit" do
    let(:domain_id)   { "100" }
    let(:record_id)   { "50" }
    let(:record_type) { "A" }
    let(:data)        { "@" }
    let(:attrs) { {record_type: record_type, data: data } }

    let(:url) { record._edit(domain_id, record_id, attrs) }

    it { url.should eq "https://api.digitalocean.com/v1/domains/#{domain_id}/records/#{record_id}/edit?client_id=client_id_required&api_key=api_key_required&record_type=#{record_type}&data=#{data}" }
  end

  describe "._destroy" do
    let(:domain_id)   { "100" }
    let(:record_id)   { "50" }

    let(:url) { record._destroy(domain_id, record_id) }

    it { url.should eq "https://api.digitalocean.com/v1/domains/#{domain_id}/records/#{record_id}/destroy?client_id=client_id_required&api_key=api_key_required" }
  end
end
