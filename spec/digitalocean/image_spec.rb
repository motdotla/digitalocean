require 'spec_helper'

describe Digitalocean::Image do
  let(:subject)   { Digitalocean::Image }

  describe "._all" do
    before do
      @url = subject._all
    end

    it do
      @url.should eq "https://api.digitalocean.com/v1/images/?client_id=client_id_required&api_key=api_key_required"
    end
  end

  describe "._all with optional parameters" do
    let(:args) { { filter: "my_images" } }

    before do
      @url = subject._all(args)
    end

    it do
      @url.should eq "https://api.digitalocean.com/v1/images/?client_id=client_id_required&api_key=api_key_required&filter=my_images"
    end
  end

  describe "._find" do
    let(:id) { "1234" }

    before do
      @url = subject._find(id)
    end

    it do
      @url.should eq "https://api.digitalocean.com/v1/images/#{id}/?client_id=client_id_required&api_key=api_key_required"
    end
  end

  describe "._destroy" do
    let(:id) { "1234" }

    before do
      @url = subject._destroy(id)
    end

    it do
      @url.should eq "https://api.digitalocean.com/v1/images/#{id}/destroy/?client_id=client_id_required&api_key=api_key_required"
    end
  end

  describe "._transfer" do
    let(:id) { "1234" }
    let(:region_id) { "44" }
    let(:args) { {region_id: region_id } }

    before do
      @url = subject._transfer(id, args)
    end

    it do
      @url.should eq "https://api.digitalocean.com/v1/images/#{id}/transfer/?client_id=client_id_required&api_key=api_key_required&region_id=44"
    end
  end
end
