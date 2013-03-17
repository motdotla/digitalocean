module Digitalocean
  class Size
    # 
    # Api calls
    # 
    def self.all
      response = Digitalocean.request.get "sizes"
      RecursiveOpenStruct.new(response.body, :recurse_over_arrays => true)
    end
    def self.find(id)
      self.all.sizes.detect{|size| size.id == id}
    end
  end
end
