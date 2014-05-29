require 'spec_helper'

describe Digitalocean::Event do
  let(:subject)   { Digitalocean::Event }

  describe "._find" do
    let(:event_id) { "1234" }

    before do
      @url = subject._find(event_id)
    end

    it do
      @url.should eq "https://api.digitalocean.com/v1/events/#{event_id}/?client_id=client_id_required&api_key=api_key_required"
    end
  end
end
