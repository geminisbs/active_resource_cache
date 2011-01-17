require 'spec_helper'

describe "ActiveResourceCache module" do
  
  before(:each) do
    @conn = ActiveResource::Connection.new('http://127.0.0.1')
  end
  
  describe "loading" do
    
    it "should add the cache_duration option" do
      ActiveResource::Connection.respond_to?(:cache_duration).should be_true
    end
    
    it "should add the get_with_resource_cache method" do
      @conn.respond_to?(:get_with_resource_cache).should be_true
    end
    
  end
  
  describe 'configuration' do
    
    it "should have a default cache duration of 60 seconds" do
      ActiveResource::Connection.cache_duration.should == 60
    end
  
    it "should have allow the user to specify a cache duration" do
      ActiveResource::Connection.cache_duration = 500
      ActiveResource::Connection.cache_duration.should == 500
    end
    
  end
  
  describe "caching" do
    
    it "should perform the GET request on a CACHE MISS" do
      RAILS_DEFAULT_LOGGER.should_receive(:add).exactly(2).times
      @conn.get('/users.xml')
    end
    
    it "should NOT perform the GET request on a CACHE HIT" do
      @conn.get('/users.xml')
      RAILS_DEFAULT_LOGGER.should_receive(:add).exactly(1).times
      @conn.get('/users.xml')
    end
    
  end
  
end
