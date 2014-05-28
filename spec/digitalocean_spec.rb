require 'spec_helper'

describe Digitalocean do
  subject(:digitalocean) { described_class }

  describe "defaults" do
    before do
      digitalocean.client_id = nil
      digitalocean.api_key   = nil
    end

    its(:api_endpoint) { should eq "https://api.digitalocean.com" }
    its(:client_id) { should eq "client_id_required" }
    its(:api_key) { should eq "api_key_required" }
    it { digitalocean::VERSION.should eq "1.0.6" }
  end

  describe "setting values" do
    let(:client_id)   { "1234" }
    let(:api_key)     { "adf3434938492fjkdfj" }

    before do
      digitalocean.client_id = client_id
      digitalocean.api_key   = api_key
    end

    its(:client_id) { should eq client_id }
    its(:api_key) { should eq api_key }
  end
end
