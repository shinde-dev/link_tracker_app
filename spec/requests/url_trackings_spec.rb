# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Url Trackings', type: :request do
  let!(:store_url) { FactoryBot.create(:store_url) }

  describe 'GET /track/:tracking_code' do
    context 'with valid tracking code' do
      it 'creates a new tracking' do
        expect(store_url.total_hits).to eq 0
        get "/track/#{store_url.tracking_code}"
        expect(response).to have_http_status(:found)
        expect(store_url.total_hits).to eq 1
      end
    end

    context 'with invalid tracking_code' do
      it 'throws 404 routing error' do
        get '/track/invalid'
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
