require 'spec_helper'

describe Digitalocean::Domain do
  let(:subject)   { Digitalocean::Domain }

  context "correct api key" do
    before do
      set_client_id_and_api_key!
    end

    describe "._all" do
      before do
        @url = subject._all
      end

      context "default" do
        it do
          @url.should eq "https://api.digitalocean.com/domains?client_id=client_id_required&api_key=api_key_required" 
        end
      end
    end

    describe "._find" do
      let(:domain_id) { "1234" }

      before do
        @url = subject._find(domain_id)
      end

      context "default" do
        it do
          @url.should eq "https://api.digitalocean.com/domains/#{domain_id}?client_id=client_id_required&api_key=api_key_required" 
        end
      end
    end

    describe "._create" do
      let(:domain_name) { "test_domain" }
      let(:ip_address)  { "test_ip_address" }

      before do
        @url = subject._create(domain_name, ip_address)
      end

      context "default" do
        it do
          @url.should eq "https://api.digitalocean.com/domains/new?client_id=client_id_required&api_key=api_key_required&name=test_domain&ip_address=test_ip_address"
        end
      end
    end

    describe "._destroy" do
      let(:domain_id) { "test_domain_id" }

      before do
        @url = subject._destroy(domain_id)
      end

      context "default" do
        it do
          @url.should eq "https://api.digitalocean.com/domains/test_domain_id/destroy?client_id=client_id_required&api_key=api_key_required"
        end
      end
    end
  end
end
