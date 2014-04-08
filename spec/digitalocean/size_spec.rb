require 'spec_helper'

describe Digitalocean::Size do
  let(:subject)   { Digitalocean::Size }

  describe "._all" do
    before do
      @url = subject._all
    end

    it do
      @url.should eq "https://api.digitalocean.com/sizes/?client_id=client_id_required&api_key=api_key_required" 
    end
  end

  describe "._find" do
    let(:size_id) { "1234" }

    before do
      @url = subject._find(size_id)
    end

    it do
      @url.should eq "https://api.digitalocean.com/sizes/#{size_id}?client_id=client_id_required&api_key=api_key_required"
    end
  end

end
