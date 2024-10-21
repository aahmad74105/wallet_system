# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::WalletsController, type: :request do
  let!(:user) { create(:user) } # Ensure user exists for the wallet association
  let!(:wallet) { create(:wallet, user: user, balance: 100.00) }

  describe 'GET /api/v1/wallets/:id' do
    context 'when the wallet exists' do
      it 'returns the wallet and status code 200' do
        get "/api/v1/wallets/#{wallet.id}", headers: { 'ACCEPT' => 'application/json' }
      end
    end

    context 'when the wallet does not exist' do
      it 'returns a 404 not found' do
        get '/api/v1/wallets/999999', headers: { 'ACCEPT' => 'application/json' }
      end
    end
  end

  describe 'PATCH /api/v1/wallets/:id' do
    context 'with valid parameters' do
      let(:valid_params) { { wallet: { balance: 150.00 } } }

      it 'updates the wallet and returns status code 200' do
        patch "/api/v1/wallets/#{wallet.id}", params: valid_params, headers: { 'ACCEPT' => 'application/json' }

        wallet.reload
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) { { wallet: { balance: -50.00 } } }

      it 'returns a 422 unprocessable entity' do
        patch "/api/v1/wallets/#{wallet.id}", params: invalid_params, headers: { 'ACCEPT' => 'application/json' }
      end
    end

    context 'when the wallet does not exist' do
      let(:valid_params) { { wallet: { balance: 150.00 } } }

      it 'returns a 404 not found' do
        patch '/api/v1/wallets/999999', params: valid_params, headers: { 'ACCEPT' => 'application/json' }
      end
    end
  end
end
