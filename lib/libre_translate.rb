require "net/http"
require "json"

class LibreTranslate
  class << self
    def translate(text:, to: "pt", from: "en")
      return if text.blank?

      uri = URI("#{base_url}/translate")
      response = Net::HTTP.post(
        uri,
        { q: text, source: from, target: to }.to_json,
        "Content-Type" => "application/json"
      )

      return text unless response.is_a?(Net::HTTPSuccess)

      parsed_response = JSON.parse(response.body)
      parsed_response["translatedText"]
    rescue StandardError => e
      Rails.logger.error("Translation error: #{e.message}")
      text
    end

    private

    def base_url
      Rails.application.config.libretranslate[:url]
    end
  end
end
