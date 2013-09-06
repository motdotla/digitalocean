module Digitalocean
  class Record
    # 
    # Api calls
    # 
    def self.all(domain_id)
      response = Digitalocean.request.get "domains/#{domain_id}/records"
      RecursiveOpenStruct.new(response.body, :recurse_over_arrays => true)
    end

    def self.find(domain_id, record_id)
      response = Digitalocean.request.get "domains/#{domain_id}/records/#{record_id}"
      RecursiveOpenStruct.new(response.body, :recurse_over_arrays => true)
    end

    # attrs = {
    #   :domain_id   => domain_id || domain_name,
    #   :record_type => 'A' || 'CNAME' || 'NS' || 'TXT' || 'MX' || 'SRV',
    #   :data        => '@' || '123.123.123.123' || ...,
    #   :name        => optional, required for A, CNAME, TXT, and SRV records,
    #   :priority    => optional, required for SRV and MX,
    #   :port        => optional, required for SRV,
    #   :weight      => optional, required for SRV
    # }
    def self.create(domain_id, record_type, data, name = nil, priority = nil, port = nil, weight = nil)
      attrs = {
        domain_id: domain_id,
        record_type: record_type,
        data: data,
        name: name,
        priority: priority,
        port: port,
        weight: weight,
      }
      response = Digitalocean.request.get "domains/#{domain_id}/records/new", attrs
      RecursiveOpenStruct.new(response.body, :recurse_over_arrays => true)
    end

    # attrs = {
    #   :domain_id   => domain_id || domain_name,
    #   :record_type => 'A' || 'CNAME' || 'NS' || 'TXT' || 'MX' || 'SRV',
    #   :data        => '@' || '123.123.123.123' || ...,
    #   :name        => optional, required for A, CNAME, TXT, and SRV records,
    #   :priority    => optional, required for SRV and MX,
    #   :port        => optional, required for SRV,
    #   :weight      => optional, required for SRV
    # }
    def self.edit(domain_id, record_id, attrs)
      attrs.merge({
          domain_id: domain_id,
          record_id: record_id
      })
      response = Digitalocean.request.get "domains/#{domain_id}/records/#{record_id}/edit", attrs
      RecursiveOpenStruct.new(response.body, :recurse_over_arrays => true)
    end

    def self.destroy(domain_id, record_id)
      response = Digitalocean.request.get "domains/#{domain_id}/records/#{record_id}/destroy"
      RecursiveOpenStruct.new(response.body, :recurse_over_arrays => true)
    end
  end
end
