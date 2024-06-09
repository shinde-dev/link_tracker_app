# frozen_string_literal: true

class Api::UrlValidator
  def self.valid?(url)
    response = Faraday.get(url)
    [200, 301, 302].include?(response.status)
  rescue StandardError
    false
  end
end
