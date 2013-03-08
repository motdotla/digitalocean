require 'spec_helper'

describe Digitalocean::Region do
  let(:ok)        { "OK" }
  let(:subject)   { Digitalocean::Region }

  context "correct api key" do
    before do
      set_client_id_and_api_key!
    end

    describe ".all" do
      before do
        @response = subject.all
      end

      context "default" do
        it do
          @response.status.should eq ok
        end
      end
    end
  end
end