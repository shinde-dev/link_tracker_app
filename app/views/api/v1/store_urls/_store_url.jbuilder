# frozen_string_literal: true

json.extract!(
  store_url,
  :id,
  :url,
  :tracking_url,
  :total_hits
)
json.client store_url.client, :name, :email
