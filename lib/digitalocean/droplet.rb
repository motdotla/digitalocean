module Digitalocean
  class Droplet
    # 
    # Api calls
    # 

    def self.destroy(droplet_id=nil)
      response = Digitalocean.request.get "droplets/#{droplet_id}/destroy"
      RecursiveOpenStruct.new(response.body, :recurse_over_arrays => true)
    end
  end
end
