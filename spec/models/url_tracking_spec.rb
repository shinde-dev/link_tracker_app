# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UrlTracking, type: :model do
  describe 'schema' do
    it { is_expected.to have_db_column(:id).of_type(:integer) }
    it { is_expected.to have_db_column(:metadata).of_type(:json) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:store_url) }
  end

  describe 'is valid' do
    it 'with correct attributes' do
      expect(FactoryBot.create(:url_tracking)).to be_valid
    end

    describe 'is invalid' do
      it 'without store_url' do
        url_tracking = FactoryBot.build(:url_tracking, store_url: nil)
        expect(url_tracking).not_to be_valid
        expect(url_tracking.errors.full_messages[0]).to eq('Store url must exist')
      end
    end
  end
end
