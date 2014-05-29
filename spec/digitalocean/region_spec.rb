require 'spec_helper'

describe Digitalocean::Region do
  subject(:region) { described_class }

  describe "._all" do
    let(:url) { region._all }

    it { url.should eq "https://api.digitalocean.com/v1/regions/?client_id=client_id_required&api_key=api_key_required" }
  end

  describe "._find" do
    let(:region_id) { "1234" }
    let(:url) { region._find(region_id) }

    it { url.should eq "https://api.digitalocean.com/v1/regions/#{region_id}?client_id=client_id_required&api_key=api_key_required" }
  end
end
