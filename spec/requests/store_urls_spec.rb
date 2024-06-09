# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Store Urls', type: :request do
  describe 'POST /create' do
    let(:client) { FactoryBot.create(:client) }
    let!(:valid_attributes) do
      {
        url: Faker::Internet.url,
        client_id: client.id
      }
    end

    context 'with valid attributes' do
      it 'creates a new store_url' do
        post api_v1_store_urls_url, params: { store_url: valid_attributes }, as: :json
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid attributes' do
      it 'does not creates a new store_url with blank params' do
        post api_v1_store_urls_url, params: { store_url: {} }, as: :json
        expect(response).to have_http_status(:bad_request)
      end

      it 'does not creates a new store_url without url' do
        post api_v1_store_urls_url, params: { store_url: valid_attributes.merge!({ url: nil }) }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.parsed_body['errors']).to eq(["Url can't be blank", 'Url is invalid'])
      end

      it 'does not creates a new store_url with invalid url' do
        post api_v1_store_urls_url, params: { store_url: valid_attributes.merge!({ url: 'url' }) }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.parsed_body['errors']).to eq(['Url is invalid'])
      end

      it 'does not creates a new store_url without url' do
        post api_v1_store_urls_url, params: { store_url: valid_attributes.merge!({ client_id: nil }) }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.parsed_body['errors']).to eq(['Client must exist'])
      end
    end
  end

  describe 'GET /show' do
    let!(:store_url) { FactoryBot.create(:store_url) }
    let(:valid_response) do
      {
        data: {
          id: store_url.id,
          url: store_url.url,
          tracking_url: store_url.tracking_url,
          total_hits: store_url.total_hits,
          client: {
            name: store_url.client.name,
            email: store_url.client.email
          }
        }
      }
    end

    context 'with valid tracking_code' do
      it 'returns store url with total hits' do
        get "/track/#{store_url.tracking_code}"
        expect(store_url.total_hits).to eq 1

        get "/api/v1/store_url/#{store_url.tracking_code}"
        expect(response.parsed_body.deep_symbolize_keys).to eq(valid_response)
      end
    end

    context 'with invalid tracking_code' do
      it 'throws 404 routing error' do
        get '/api/v1/store_url/invalid'
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
