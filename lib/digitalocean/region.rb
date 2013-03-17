module Digitalocean
  class Region
    # 
    # Api calls
    # 
    def self.all
      response = Digitalocean.request.get "regions"
      RecursiveOpenStruct.new(response.body, :recurse_over_arrays => true)
    end
    def self.find(id)
      self.all.regions.detect{|region| region.id == id}
    end
  end
end
