# frozen_string_literal: true

class StoreUrl < ApplicationRecord
  belongs_to :client
  has_many :url_trackings, dependent: :nullify

  validates :url, presence: true, format: URI::DEFAULT_PARSER.make_regexp(%w[http https])
  validates :tracking_code, uniqueness: true

  def tracking_url
    "#{ENV.fetch('TRACKING_ROOT_URL')}/#{tracking_code}"
  end

  def total_hits
    url_trackings.count
  end
end
