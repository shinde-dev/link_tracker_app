# frozen_string_literal: true

class Client < ApplicationRecord
  has_many :store_urls, dependent: :nullify

  validates :name, presence: true
  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
