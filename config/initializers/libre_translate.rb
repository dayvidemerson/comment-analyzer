# frozen_string_literal: true

Rails.application.configure do
  config.libretranslate = {
    url: ENV.fetch("LIBRETRANSLATE_URL", "http://translate:5000")
  }
end
