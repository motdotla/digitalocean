require 'spec_helper'

describe Digitalocean::Event do
  subject(:event) { described_class }

  describe "._find" do
    let(:event_id) { "1234" }
    let(:url) { event._find(event_id) }

    it { url.should eq "https://api.digitalocean.com/v1/events/#{event_id}/?client_id=client_id_required&api_key=api_key_required" }
  end
end
