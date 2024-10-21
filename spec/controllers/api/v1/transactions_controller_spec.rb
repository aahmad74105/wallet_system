# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::TransactionsController, type: :request do
  let!(:user) { create(:user) }
  let!(:target_wallet) { create(:wallet, user: user) }

  describe 'POST /api/v1/transactions' do
    context 'with valid attributes' do
      let(:valid_attributes) { { wallet_id: target_wallet.id, amount: 100 } }

      it 'creates a new transaction' do
        expect do
          post '/api/v1/transactions', params: { transaction: valid_attributes }
        end.to change(Transaction, :count).by(0)
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new transaction' do
        expect do
          post '/api/v1/transactions', params: { transaction: { wallet_id: nil, amount: nil } }
        end.not_to change(Transaction, :count)
      end
    end
  end
end
