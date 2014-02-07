module Digitalocean
  class Domain
    DOMAIN_URLS = {
      "all"       => "https://api.digitalocean.com/domains?client_id=[your_client_id]&api_key=[your_api_key]",
      "find"      => "https://api.digitalocean.com/domains/[domain_id]?client_id=[your_client_id]&api_key=[your_api_key]",
      "create"    => "https://api.digitalocean.com/domains/new?client_id=[your_client_id]&api_key=[your_api_key]&name=[domain]&ip_address=[ip_address]", 
      "destroy"   => "https://api.digitalocean.com/domains/[domain_id]/destroy?client_id=[your_client_id]&api_key=[your_api_key]" 
    }

    class << self
      DOMAIN_URLS.each do |method_name, url|
        parts           = url.split("?")
        pre_query       = parts[0]
        post_query      = parts[1]

        define_method("_#{method_name}") do |*args|
          pre_query = Digitalocean.process_args_from_part(pre_query, args)
          post_query = Digitalocean.inject_client_id_and_api_key(post_query)
          post_query = Digitalocean.process_args_from_part(post_query, args)

          [pre_query, post_query].join("?")
        end

        define_method(method_name) do |*args|
          request_and_respond "_#{method_name}", *args
        end
      end
    end
  end
end
