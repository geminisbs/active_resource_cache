module ActiveResourceCache

  def self.extended(base)
    base.send(:include, InstanceMethods)
    base.class_eval do
      cattr_accessor :cache_duration
      self.cache_duration = 60
    end
    base.class_eval do
      alias_method_chain :get, :resource_cache
    end
  end
  
  module InstanceMethods
    
    def get_with_resource_cache(path, headers = {})
      cache_key = Digest::SHA1.hexdigest([self.site, path, headers.to_s].join('#'))
      
      response = Rails.cache.fetch(cache_key, :expires_in => self.class.cache_duration) {
        RAILS_DEFAULT_LOGGER.info("ActiveResourceCache CACHE MISS KEY #{cache_key}")
        get_without_resource_cache(path, headers)
      }
      RAILS_DEFAULT_LOGGER.info("ActiveResourceCache CACHE HIT KEY #{cache_key}")
      
      response.dup
    end
    
  end
  
end