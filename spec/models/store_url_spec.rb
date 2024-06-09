# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StoreUrl, type: :model do
  describe 'schema' do
    it { is_expected.to have_db_column(:id).of_type(:integer) }
    it { is_expected.to have_db_column(:url).of_type(:string) }
    it { is_expected.to have_db_column(:tracking_code).of_type(:string) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:client) }
    it { is_expected.to have_many(:url_trackings) }
  end

  describe 'is valid' do
    it 'with correct attributes' do
      expect(FactoryBot.create(:store_url)).to be_valid
    end

    it 'without tracking_code' do
      store_url = FactoryBot.build(:store_url, tracking_code: nil)
      expect(store_url).to be_valid
    end
  end

  describe 'is invalid' do
    it 'without url' do
      store_url = FactoryBot.build(:store_url, url: nil)
      expect(store_url).not_to be_valid
      expect(store_url.errors.full_messages[0]).to eq("Url can't be blank")
    end

    it 'without client' do
      store_url = FactoryBot.build(:store_url, client: nil)
      expect(store_url).not_to be_valid
      expect(store_url.errors.full_messages[0]).to eq('Client must exist')
    end

    it 'with duplicate tracking_code' do
      store_url1 = FactoryBot.create(:store_url)
      store_url = FactoryBot.build(:store_url, tracking_code: store_url1.tracking_code)
      expect(store_url).not_to be_valid
      expect(store_url.errors.full_messages[0]).to eq('Tracking code has already been taken')
    end

    it 'with invalid url' do
      store_url = FactoryBot.build(:store_url, url: 'url')
      expect(store_url).not_to be_valid
      expect(store_url.errors.full_messages[0]).to eq('Url is invalid')
    end
  end
end
