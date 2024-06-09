# frozen_string_literal: true

FactoryBot.define do
  factory :store_url do
    url { Faker::Internet.url }
    tracking_code { Faker::Internet.uuid }
    client { FactoryBot.create(:client) }
  end
end
