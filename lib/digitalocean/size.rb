module Digitalocean
  class Size
    # 
    # Api calls
    # 
    def self.all
      response = Digitalocean.request.get "sizes"
      RecursiveOpenStruct.new(response.body, :recurse_over_arrays => true)
    end
  end
end
