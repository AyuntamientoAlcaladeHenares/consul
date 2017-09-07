module Consul
  class Application < Rails::Application
    require Rails.root.join('lib/custom/sms_api')
    require Rails.root.join('lib/custom/census_api')
  end
end
