require 'spec_helper'

describe Digitalocean::Droplet do
  let(:ok)        { "OK" }
  let(:subject)   { Digitalocean::Droplet }

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

      describe ".retrieve" do
        before do
          droplet_id = @response.droplets.first.id
          @response2 = subject.retrieve(droplet_id)
        end

        context "default" do
          it do
            @response2.status.should eq ok
          end
        end
      end

      describe ".snapshot" do
        let(:snapshot_name) { ["digitalocean_spec_", SecureRandom.hex(15)].join }

        before do
          droplet_id = @response.droplets.first.id
          @response2 = subject.snapshot(droplet_id, snapshot_name)
        end

        context "default" do
          it do
            @response2.status.should eq ok
          end
        end
      end
    end
  end
end