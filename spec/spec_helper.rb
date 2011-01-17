$:.unshift(File.dirname(__FILE__) + '/../lib')

require 'rspec'
require 'logger'
require 'fakeweb'

require 'rails'
require 'active_resource'
require 'action_controller'

# Setup the cache store to use during testing
RAILS_CACHE = ActiveSupport::Cache.lookup_store(:memory_store)

# Discard logs
RAILS_DEFAULT_LOGGER = ActiveSupport::BufferedLogger.new('/dev/null')

# Setup fake replies for ActiveResource
xml_response = <<-END
  <?xml version="1.0" encoding="UTF-8"?>
  <records type="array">
    <record>
      <id type="integer">209</id>
      <last-name>John</last-name>
      <first-name>Smith</first-name>
      <email>jsmith@somedomain.com</email>
    </record>
  </records>
END

FakeWeb.register_uri(:get, "http://127.0.0.1/users.xml", :body => xml_response)

require (File.dirname(__FILE__) + '/../init')
