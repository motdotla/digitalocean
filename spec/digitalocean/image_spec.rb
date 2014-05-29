require 'spec_helper'

describe Digitalocean::Image do
  subject(:image) { described_class }

  describe "._all" do
    let(:url) { image._all }
    it { url.should eq "https://api.digitalocean.com/v1/images/?client_id=client_id_required&api_key=api_key_required" }
  end

  describe "._all with optional parameters" do
    let(:args) { { filter: "my_images" } }
    let(:url) { image._all(args) }

    it { url.should eq "https://api.digitalocean.com/v1/images/?client_id=client_id_required&api_key=api_key_required&filter=my_images" }
  end

  describe "._find" do
    let(:id) { "1234" }
    let(:url) { image._find(id) }

    it { url.should eq "https://api.digitalocean.com/v1/images/#{id}/?client_id=client_id_required&api_key=api_key_required" }
  end

  describe "._destroy" do
    let(:id) { "1234" }
    let(:url) { image._destroy(id) }

    it { url.should eq "https://api.digitalocean.com/v1/images/#{id}/destroy/?client_id=client_id_required&api_key=api_key_required" }
  end

  describe "._transfer" do
    let(:id) { "1234" }
    let(:region_id) { "44" }
    let(:args) { {region_id: region_id } }

    let(:url) { image._transfer(id, args) }

    it { url.should eq "https://api.digitalocean.com/v1/images/#{id}/transfer/?client_id=client_id_required&api_key=api_key_required&region_id=44" }
  end
end
