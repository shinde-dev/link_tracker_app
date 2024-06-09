# frozen_string_literal: true

class UrlTrackingsController < ApplicationController
  def track
    url_tracking = UrlTracking::Track.call(params[:tracking_code])
    raise ActionController::RoutingError, 'Not Found' unless url_tracking&.valid?

    redirect_to(url_tracking.store_url.url, allow_other_host: true)
  end
end
