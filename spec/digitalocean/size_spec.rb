require 'spec_helper'

describe Digitalocean::Size do
  subject(:size) { described_class }

  describe "._all" do
    let(:url) { size._all }
    it { url.should eq "https://api.digitalocean.com/v1/sizes/?client_id=client_id_required&api_key=api_key_required"  }
  end

  describe "._find" do
    let(:size_id) { "1234" }
    let(:url) { size._find(size_id) }

    it { url.should eq "https://api.digitalocean.com/v1/sizes/#{size_id}?client_id=client_id_required&api_key=api_key_required" }
  end
end
