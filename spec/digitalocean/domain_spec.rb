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
          @url.should eq "https://api.digitalocean.com/domains?client_id=[your_client_id]&api_key=[your_api_key]" 
        end
      end
    end

    describe "._find" do
      let(:domain_id) { "[domain_id]" }

      before do
        @url = subject._find(domain_id)
      end

      context "default" do
        it do
          @url.should eq "https://api.digitalocean.com/domains/[domain_id]?client_id=[your_client_id]&api_key=[your_api_key]" 
        end
      end
    end

    describe "._create" do
      let(:domain_name) { "[domain]" }
      let(:ip_address)  { "[ip_address]" }

      before do
        @url = subject._create(domain_name, ip_address)
      end

      context "default" do
        it do
          @url.should eq "https://api.digitalocean.com/domains/new?client_id=[your_client_id]&api_key=[your_api_key]&name=[domain]&ip_address=[ip_address]"
        end
      end
    end

    describe "._destroy" do
      let(:domain_id) { "[domain_id]" }

      before do
        @url = subject._destroy(domain_id)
      end

      context "default" do
        it do
          @url.should eq "https://api.digitalocean.com/domains/[domain_id]/destroy?client_id=[your_client_id]&api_key=[your_api_key]"
        end
      end
    end
  end
end
