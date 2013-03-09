module Digitalocean
  class Droplet
    # 
    # Api calls
    # 
    def self.all
      response = Digitalocean.request.get "droplets"
      RecursiveOpenStruct.new(response.body, :recurse_over_arrays => true)
    end

    def self.retrieve(droplet_id)
      response = Digitalocean.request.get "droplets/#{droplet_id}"
      RecursiveOpenStruct.new(response.body, :recurse_over_arrays => true)
    end

    def self.reboot(droplet_id=nil)
      response = Digitalocean.request.get "droplets/#{droplet_id}/reboot"
      RecursiveOpenStruct.new(response.body, :recurse_over_arrays => true)
    end

    def self.power_cycle(droplet_id=nil)
      response = Digitalocean.request.get "droplets/#{droplet_id}/power_cycle"
      RecursiveOpenStruct.new(response.body, :recurse_over_arrays => true)
    end

    def self.shut_down(droplet_id=nil)
      response = Digitalocean.request.get "droplets/#{droplet_id}/shut_down"
      RecursiveOpenStruct.new(response.body, :recurse_over_arrays => true)
    end

    def self.power_off(droplet_id=nil)
      response = Digitalocean.request.get "droplets/#{droplet_id}/power_off"
      RecursiveOpenStruct.new(response.body, :recurse_over_arrays => true)
    end

    def self.power_on(droplet_id=nil)
      response = Digitalocean.request.get "droplets/#{droplet_id}/power_on"
      RecursiveOpenStruct.new(response.body, :recurse_over_arrays => true)
    end

    def self.snapshot(droplet_id=nil, snapshot_name=nil)
      response = Digitalocean.request.get "droplets/#{droplet_id}/snapshot", {:name => snapshot_name}
      RecursiveOpenStruct.new(response.body, :recurse_over_arrays => true)
    end

    # attrs = {
    #   :name =>        droplet_name, 
    #   :size_id =>     size_id, 
    #   :image_id =>    image_id,
    #   :region_id =>   region_id
    # }
    def self.create(attrs)
      response = Digitalocean.request.get "droplets/new", attrs
      RecursiveOpenStruct.new(response.body, :recurse_over_arrays => true) 
    end

    def self.destroy(droplet_id=nil)
      response = Digitalocean.request.get "droplets/#{droplet_id}/destroy"
      RecursiveOpenStruct.new(response.body, :recurse_over_arrays => true)
    end
  end
end
