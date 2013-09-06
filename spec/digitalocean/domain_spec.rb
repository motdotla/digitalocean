require 'spec_helper'

describe Digitalocean::Domain do
  let(:ok)        { "OK" }
  let(:subject)   { Digitalocean::Domain }

  context "correct api key" do
    before do
      set_client_id_and_api_key!
    end

    describe ".all" do
      before do
        @response = subject.all
      end

      context "default" do
        it do
          @response.status.should eq ok
        end
      end

      describe ".find" do
        before do
          domain_id = @response.domains.first.id
          @response2 = subject.find(domain_id)
        end

        context "default" do
          it do
            @response2.status.should eq ok
          end
        end
      end

      describe ".create" do
        let(:domain_name) { ["digitalocean_spec_", SecureRandom.hex(15), ".com"].join }

        before do
          domain = @response.domains.first
          @response_create = subject.create(domain_name, domain.ip_address)
        end

        context "default" do
          it do
            @response_create.status.should eq ok
          end
        end
      end

      describe ".destroy" do
        let(:domain_name) { ["digitalocean_spec_", SecureRandom.hex(15), ".com"].join }

        before do
          droplet = @response.droplets.first
          @response_create = subject.create(domain_name, droplet.ip_address)
          @response_destroy = subject.destroy(@response_create.id)
        end

        context "default" do
          it do
            @response_destroy.status.should eq ok
          end
        end
      end

    end
  end
end