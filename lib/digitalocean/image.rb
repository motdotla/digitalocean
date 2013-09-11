module Digitalocean
  class Image
    # 
    # Api calls
    # 
    def self.all(attrs={})
      response = Digitalocean.request.get "images", attrs
      RecursiveOpenStruct.new(response.body, :recurse_over_arrays => true)
    end
    def self.find(id)
      response = Digitalocean.request.get "images/#{id}"
      RecursiveOpenStruct.new(response.body, :recurse_over_arrays => true).image
    end
    def self.destroy(id)
      response = Digitalocean.request.get "images/#{id}/destroy"
      RecursiveOpenStruct.new(response.body, :recurse_over_arrays => true).image
    end
    def self.transfer(id, region_id)
      response = Digitalocean.request.get "images/#{id}/transfer", { region_id: region_id }
      RecursiveOpenStruct.new(response.body, :recurse_over_arrays => true).image
    end
  end
end
