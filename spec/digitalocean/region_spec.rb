require 'spec_helper'

describe Digitalocean::Region do
  let(:subject)   { Digitalocean::Region }

  context "correct api key" do
    before do
      set_client_id_and_api_key!
    end

    describe "._all" do
      before do
        @url = subject._all
      end

      context "default" do
        it do
          @url.should eq "https://api.digitalocean.com/regions/?client_id=client_id_required&api_key=api_key_required"
        end
      end
    end
  end
end
