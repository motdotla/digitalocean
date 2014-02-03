module Digitalocean
  class Domain

    def self.request_and_respond(url)
      response = Digitalocean.request.get url
      RecursiveOpenStruct.new(response.body, :recurse_over_arrays => true)
    end

    def self._all
      Digitalocean.build_url("/domains")
    end

    def self._find(domain_id)
      Digitalocean.build_url("/domains/#{domain_id}")
    end

    def self._create(domain_name, ip_address)
      attrs = {
        name:       domain_name,
        ip_address: ip_address
      }
      Digitalocean.build_url("/domains/new", attrs)
    end

    def self._destroy(domain_id)
      Digitalocean.build_url("/domains/#{domain_id}/destroy")
    end

    # 
    # Api calls
    # 
    def self.all
      request_and_respond _all
    end

    def self.find(domain_id)
      request_and_respond _find(domain_id)
    end

    def self.create(domain_name, ip_address)
      request_and_respond _create(domain_name, ip_address)
    end

    def self.destroy(domain_id)
      request_and_respond _destroy(domain_id)
    end
  end
end
