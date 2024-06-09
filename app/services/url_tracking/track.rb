# frozen_string_literal: true

class UrlTracking::Track < Base
  def initialize(tracking_code)
    @tracking_code = tracking_code
  end

  def call
    store_url = StoreUrl.find_by(tracking_code: tracking_code)
    return unless store_url

    store_url.url_trackings.create
  end

  private

  attr_reader :tracking_code
end
