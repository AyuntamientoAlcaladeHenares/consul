module Consul
  class Application < Rails::Application
    require Rails.root.join('lib/custom/sms_api')
  end
end
