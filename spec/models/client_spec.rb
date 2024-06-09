# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Client, type: :model do
  describe 'schema' do
    it { is_expected.to have_db_column(:id).of_type(:integer) }
    it { is_expected.to have_db_column(:name).of_type(:string) }
    it { is_expected.to have_db_column(:email).of_type(:string) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:store_urls) }
  end

  describe 'is valid' do
    it 'with correct attributes' do
      expect(FactoryBot.create(:client)).to be_valid
    end
  end

  describe 'is invalid' do
    it 'without name' do
      client = FactoryBot.build(:client, name: nil)
      expect(client).not_to be_valid
      expect(client.errors.full_messages[0]).to eq("Name can't be blank")
    end

    it 'without email' do
      client = FactoryBot.build(:client, email: nil)
      expect(client).not_to be_valid
      expect(client.errors.full_messages[0]).to eq('Email is invalid')
    end

    it 'with duplicate email' do
      client1 = FactoryBot.create(:client)
      client = FactoryBot.build(:client, email: client1.email)
      expect(client).not_to be_valid
      expect(client.errors.full_messages[0]).to eq('Email has already been taken')
    end

    it 'with invalid email' do
      client = FactoryBot.build(:client, email: 'email')
      expect(client).not_to be_valid
      expect(client.errors.full_messages[0]).to eq('Email is invalid')
    end
  end
end
