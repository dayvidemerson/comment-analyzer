require 'net/http'
require 'json'

module JsonPlaceHolder
  class Error < StandardError; end

  class Base
    BASE_URL = 'https://jsonplaceholder.typicode.com'.freeze

    class << self
      protected

      def get(path)
        uri = URI(BASE_URL + path)
        response = Net::HTTP.get_response(uri)
        
        handle_response(response)
      end
  
      def handle_response(response)
        case response
        when Net::HTTPSuccess
          JSON.parse(response.body)
        else
          raise JsonPlaceHolder::Error, "Erro na API: #{response.code} - #{response.message}"
        end
      end
    end
  end
end
