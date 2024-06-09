# frozen_string_literal: true

class StoreUrl < ApplicationRecord
  belongs_to :client

  validates :url, presence: true, format: URI::DEFAULT_PARSER.make_regexp(%w[http https])
  validates :tracking_code, uniqueness: true
end
