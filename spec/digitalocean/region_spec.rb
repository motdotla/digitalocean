require 'spec_helper'

describe Digitalocean::Region do
  let(:subject)   { Digitalocean::Region }

  describe "._all" do
    before do
      @url = subject._all
    end

    it do
      @url.should eq "https://api.digitalocean.com/regions/?client_id=client_id_required&api_key=api_key_required"
    end
  end

  describe "._find" do
    let(:region_id) { "1234" }

    before do
      @url = subject._find(region_id)
    end

    it do
      @url.should eq "https://api.digitalocean.com/regions/#{region_id}?client_id=client_id_required&api_key=api_key_required"
    end
  end

end
