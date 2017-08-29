require "open-uri"
require "xmlrpc/client"

class SMSApi
  attr_accessor :client

  def initialize
    uri = URI.parse(url)

    @client = XMLRPC::Client.new(uri.host, uri.path, uri.port, nil, nil, nil, nil, true)
  end

  def url
    return "" unless end_point_available?

    Rails.application.secrets.sms_end_point
  end

  def sms_deliver(phone, code)
    return stubbed_response unless end_point_available?

    ok, param = client.call2("MensajeriaNegocios.enviarSMS", Rails.application.secrets.sms_username, Rails.application.secrets.sms_password,
                             [[ phone, "Clave para verificarte: #{code}. Gobierno Abierto", "AytoAlcala"]])
    success?(ok)
  end

  def success?(response)
    response == true
  end

  def end_point_available?
    Rails.env.staging? || Rails.env.preproduction? || Rails.env.production?
  end

  def stubbed_response
    {
      respuesta_sms: {
        identificador_mensaje: "1234567",
        fecha_respuesta: "Thu, 20 Aug 2015 16:28:05 +0200",
        respuesta_pasarela: {
          codigo_pasarela: "0000",
          descripcion_pasarela: "Operación ejecutada correctamente."
        },
        respuesta_servicio_externo: {
          codigo_respuesta: "1000",
          texto_respuesta: "Success"
        }
      }
    }
  end
end
