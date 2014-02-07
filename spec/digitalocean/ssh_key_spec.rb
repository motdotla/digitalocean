require 'spec_helper'

describe Digitalocean::SshKey do
  let(:subject)   { Digitalocean::SshKey }

  context "correct api key" do
    before do
      set_client_id_and_api_key!
    end

    describe "._all" do
      before do
        @url = subject._all
      end

      it do
        @url.should eq "https://api.digitalocean.com/ssh_keys/?client_id=client_id_required&api_key=api_key_required" 
      end
    end

    describe "._find" do
      let(:ssh_key_id) { "test_key" }
      before do
        @url = subject._find(ssh_key_id)
      end

      it do
        @url.should eq "https://api.digitalocean.com/ssh_keys/test_key/?client_id=client_id_required&api_key=api_key_required" 
      end
    end

    describe "._create" do
      let(:name)        { "test_name" }
      let(:ssh_pub_key) { "test_pub_key" }
      let(:attrs) { { name: name, ssh_pub_key: ssh_pub_key } }

      before do
        @url = subject._create(attrs)
      end

      it do
        @url.should eq "https://api.digitalocean.com/ssh_keys/new/?name=#{name}&ssh_pub_key=#{ssh_pub_key}&client_id=client_id_required&api_key=api_key_required" 
      end
    end
  end
end
