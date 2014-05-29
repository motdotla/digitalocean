require 'spec_helper'

describe Digitalocean::SshKey do
  subject(:ssh_key) { described_class }

  describe "._all" do
    let(:url) { ssh_key._all }

    it { url.should eq "https://api.digitalocean.com/v1/ssh_keys/?client_id=client_id_required&api_key=api_key_required"  }
  end

  describe "._find" do
    let(:ssh_key_id) { "test_key" }
    let(:url) { ssh_key._find(ssh_key_id) }

    it { url.should eq "https://api.digitalocean.com/v1/ssh_keys/test_key/?client_id=client_id_required&api_key=api_key_required"  }
  end

  describe "._edit" do
    let(:ssh_key_id) { "test_key" }
    let(:ssh_pub_key) { "test_pub_key" }
    let(:name) { "test_name" }
    let(:attrs) { { name: name, ssh_pub_key: ssh_pub_key } }
    let(:url) { ssh_key._edit(ssh_key_id, attrs) }

    it { url.should eq "https://api.digitalocean.com/v1/ssh_keys/test_key/edit/?name=#{name}&ssh_pub_key=#{ssh_pub_key}&client_id=client_id_required&api_key=api_key_required"  }
  end

  describe "._create" do
    let(:name)        { "test_name" }
    let(:ssh_pub_key) { "test_pub_key" }
    let(:attrs) { { name: name, ssh_pub_key: ssh_pub_key } }

    let(:url) { ssh_key._create(attrs) }

    it { url.should eq "https://api.digitalocean.com/v1/ssh_keys/new/?name=#{name}&ssh_pub_key=#{ssh_pub_key}&client_id=client_id_required&api_key=api_key_required"  }
  end

  describe "._destroy" do
    let(:ssh_key_id) { "test_key" }
    let(:url) { ssh_key._destroy(ssh_key_id) }

    it { url.should eq "https://api.digitalocean.com/v1/ssh_keys/#{ssh_key_id}/destroy/?client_id=client_id_required&api_key=api_key_required"  }
  end
end
