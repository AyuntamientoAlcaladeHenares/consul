module Consul
  class Application < Rails::Application
    require Rails.root.join('lib/custom/sms_api')
    require Rails.root.join('lib/custom/census_api')

    config.i18n.default_locale = :es

    if Rails.env.production?
      config.i18n.available_locales = [:es]
    else
      config.i18n.available_locales = [:es, :en]
    end
  end
end
