require 'spec_helper'

describe "integrations" do
  before do
    Digitalocean.send(:setup_request!)
  end

  it "makes a real call" do
    regions = Digitalocean::Region.all
    regions.status.should eq "ERROR"
  end
end
