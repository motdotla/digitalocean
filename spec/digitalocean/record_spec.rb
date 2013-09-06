require 'spec_helper'

describe Digitalocean::Record do
  let(:ok)        { "OK" }
  let(:subject)   { Digitalocean::Record }

  context "correct api key" do
    before do
      set_client_id_and_api_key!
    end

    describe ".all" do
      before do
        domain_id = @response.domains.first.id
        @response = subject.all(domain_id)
      end

      context "default" do
        it do
          @response.status.should eq ok
        end
      end

      describe ".find" do
        before do
          domain_id = @response.domains.first.id
          record_id = subject.all(domain_id).first.id
          @response2 = subject.find(domain_id, record_id)
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
          @response_create = subject.create(domain.id, 'CNAME', 'www', '@')
        end

        context "default" do
          it do
            @response_create.status.should eq ok
          end
        end
      end

      describe ".edit" do

        before do
          domain = @response.domains.first
          record = subject.all(domain.id).first
          @response_create = subject.edit(domain.id, record.id, { data: '@' })
        end

        context "default" do
          it do
            @response_create.status.should eq ok
          end
        end
      end

      describe ".destroy" do

        before do
          domain = @response.domains.first
          record = subject.all(domain.id).first@response_create = subject.create(domain_name, droplet.ip_address)
          @response_destroy = subject.destroy(domain.id, record.id)
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