# frozen_string_literal: true

class StoreUrl::Create < Base
  def initialize(url, client_id)
    @url = url
    @client_id = client_id
  end

  def call
    StoreUrl.create(url: url, client_id: client_id, tracking_code: generate_tracking_code)
  end

  private

  attr_reader :url, :client_id

  def generate_tracking_code
    SecureRandom.uuid
  end
end
