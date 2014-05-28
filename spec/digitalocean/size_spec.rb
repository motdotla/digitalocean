require 'spec_helper'

describe Digitalocean::Size do
  let(:subject)   { Digitalocean::Size }

  describe "._all" do
    before do
      @url = subject._all
    end

    it do
      @url.should eq "https://api.digitalocean.com/v1/sizes/?client_id=client_id_required&api_key=api_key_required" 
    end
  end
end
