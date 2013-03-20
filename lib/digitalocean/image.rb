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
  end
end
