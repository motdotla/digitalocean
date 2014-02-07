require 'spec_helper'

describe Digitalocean::Record do
  let(:subject)   { Digitalocean::Record }

  describe "._all" do
    let(:domain_id) { "100" }

    before do
      @url = subject._all(domain_id)
    end

    it do
      @url.should eq "https://api.digitalocean.com/domains/#{domain_id}/records?client_id=client_id_required&api_key=api_key_required"
    end
  end

  describe "._find" do
    let(:domain_id) { "100" }
    let(:record_id) { "50" }

    before do
      @url = subject._find(domain_id, record_id)
    end

    it do
      @url.should eq "https://api.digitalocean.com/domains/#{domain_id}/records/#{record_id}?client_id=client_id_required&api_key=api_key_required"
    end
  end

  describe "._create" do
    let(:domain_id)   { "100" }
    let(:record_type) { "A" }
    let(:data)        { "@" }
    let(:attrs) { {record_type: record_type, data: data } }

    before do
      @url = subject._create(domain_id, attrs)
    end

    it do
      @url.should eq "https://api.digitalocean.com/domains/#{domain_id}/records/new?client_id=client_id_required&api_key=api_key_required&record_type=#{record_type}&data=#{data}"
    end
  end

  describe "._edit" do
    let(:domain_id)   { "100" }
    let(:record_id)   { "50" }
    let(:record_type) { "A" }
    let(:data)        { "@" }
    let(:attrs) { {record_type: record_type, data: data } }

    before do
      @url = subject._edit(domain_id, record_id, attrs)
    end

    it do
      @url.should eq "https://api.digitalocean.com/domains/#{domain_id}/records/#{record_id}/edit?client_id=client_id_required&api_key=api_key_required&record_type=#{record_type}&data=#{data}"
    end
  end

  describe "._destroy" do
    let(:domain_id)   { "100" }
    let(:record_id)   { "50" }

    before do
      @url = subject._destroy(domain_id, record_id)
    end

    it do
      @url.should eq "https://api.digitalocean.com/domains/#{domain_id}/records/#{record_id}/destroy?client_id=client_id_required&api_key=api_key_required"
    end
  end
end
