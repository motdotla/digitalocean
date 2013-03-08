require 'spec_helper'

describe Digitalocean do
  subject { Digitalocean }

  describe "defaults" do
    before do
      subject.client_id       = nil
      subject.api_key         = nil
    end

    it { subject.api_endpoint.should eq "https://api.digitalocean.com" }
    it { subject.client_id.should eq "missing_client_id" }
    it { subject.api_key.should eq "missing_api_key" }
  end

  describe "setting values" do
    let(:client_id)   { "1234" }
    let(:api_key)     { "adf3434938492fjkdfj" }

    before do
      subject.client_id   = client_id
      subject.api_key     = api_key
    end

    it { subject.client_id.should eq client_id }
    it { subject.api_key.should eq api_key }
  end
end