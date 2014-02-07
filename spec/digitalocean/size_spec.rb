require 'spec_helper'

describe Digitalocean::Size do
  let(:subject)   { Digitalocean::Size }

  context "correct api key" do
    before do
      set_client_id_and_api_key!
    end

    describe "._all" do
      before do
        @url = subject._all
      end

      it do
        @url.should eq "https://api.digitalocean.com/sizes/?client_id=client_id_required&api_key=api_key_required" 
      end
    end
  end
end
