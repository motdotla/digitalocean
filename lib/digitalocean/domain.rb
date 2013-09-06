module Digitalocean
  class Domain
    # 
    # Api calls
    # 
    def self.all
      response = Digitalocean.request.get "domains"
      RecursiveOpenStruct.new(response.body, :recurse_over_arrays => true)
    end

    def self.find(domain_id)
      response = Digitalocean.request.get "domains/#{domain_id}"
      RecursiveOpenStruct.new(response.body, :recurse_over_arrays => true)
    end

    # attrs = {
    #   :name =>        domain_name,
    #   :ip_address =>  ip_address
    # }
    def self.create(domain_name, ip_address)
      attrs = {
          name: domain_name,
          ip_address: ip_address
      }
      response = Digitalocean.request.get "domains/new", attrs
      RecursiveOpenStruct.new(response.body, :recurse_over_arrays => true)
    end

    def self.destroy(domain_id)
      response = Digitalocean.request.get "domains/#{domain_id}/destroy"
      RecursiveOpenStruct.new(response.body, :recurse_over_arrays => true)
    end
  end
end
