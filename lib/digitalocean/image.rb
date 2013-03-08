module Digitalocean
  class Image
    # 
    # Api calls
    # 
    def self.all(attrs={})
      response = Digitalocean.request.get "images", attrs
      RecursiveOpenStruct.new(response.body, :recurse_over_arrays => true)
    end
  end
end
