require 'spec_helper'

describe Digitalocean do
  subject(:digitalocean) { described_class }

  before do
    digitalocean.client_id = client_id
    digitalocean.api_key   = api_key
  end

  describe "defaults" do
    let(:client_id) { nil }
    let(:api_key)   { nil}

    its(:api_endpoint) { should eq "https://api.digitalocean.com" }
    its(:client_id)    { should eq "client_id_required" }
    its(:api_key)      { should eq "api_key_required" }

    it { digitalocean::VERSION.should eq "1.1.0" }
  end

  describe "setting values" do
    let(:client_id) { "1234" }
    let(:api_key)   { "adf3434938492fjkdfj" }

    its(:client_id) { should eq client_id }
    its(:api_key)   { should eq api_key }
  end
end
