module Digitalocean
  class SshKey
    # 
    # Api calls
    # 
    def self.all
      response = Digitalocean.request.get "ssh_keys"
      RecursiveOpenStruct.new(response.body, :recurse_over_arrays => true)
    end

    def self.retrieve(ssh_key_id=nil)
      response = Digitalocean.request.get "ssh_keys/#{ssh_key_id}"
      RecursiveOpenStruct.new(response.body, :recurse_over_arrays => true)
    end

    def self.create(attrs)
      response = Digitalocean.request.get "ssh_keys/new", attrs
      RecursiveOpenStruct.new(response.body, :recurse_over_arrays => true)
    end
  end
end
