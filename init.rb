require "digest/sha1"
require 'active_resource_cache'
ActiveResource::Connection.extend ActiveResourceCache
