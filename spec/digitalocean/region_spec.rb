require 'spec_helper'

describe Digitalocean::Region do
  let(:subject)   { Digitalocean::Region }

  describe "._all" do
    before do
      @url = subject._all
    end

    it do
      @url.should eq "https://api.digitalocean.com/v1/regions/?client_id=client_id_required&api_key=api_key_required"
    end
  end
end
