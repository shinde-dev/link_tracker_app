# frozen_string_literal: true

FactoryBot.define do
  factory :url_tracking do
    metadata { { key: 'value' } }
    store_url { FactoryBot.create(:store_url) }
  end
end
