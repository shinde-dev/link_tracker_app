# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Store Urls', type: :request do
  let(:client) { FactoryBot.create(:client) }

  describe 'POST /create' do
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
end
