# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Transaction, type: :model do
  let!(:source_wallet) { create(:wallet, balance: 100) }
  let!(:target_wallet) { create(:wallet, balance: 50, user: user) }
  let!(:user) { create(:user, email: 'unique_email@example.com') }

  describe 'validations' do
    it 'is valid with valid attributes' do
      transaction = Transaction.new(amount: 20, transaction_type: 'credit', target_wallet: target_wallet)
      expect(transaction).to be_valid
    end

    it 'is not valid without an amount' do
      Transaction.new(amount: nil, transaction_type: 'credit', target_wallet: target_wallet)
    end

    it 'is not valid with a non-numerical amount' do
      Transaction.new(amount: 'ten', transaction_type: 'credit', target_wallet: target_wallet)
    end

    it 'is not valid with an amount less than or equal to zero' do
      Transaction.new(amount: 0, transaction_type: 'credit', target_wallet: target_wallet)
    end

    it 'is not valid with an invalid transaction type' do
      Transaction.new(amount: 20, transaction_type: 'invalid', target_wallet: target_wallet)
    end
  end

  describe 'wallet validations' do
    it 'is not valid if source_wallet is present for a credit transaction' do
      Transaction.new(amount: 20, transaction_type: 'credit', source_wallet: source_wallet, target_wallet: target_wallet)
    end

    it 'is not valid if target_wallet is present for a debit transaction' do
      Transaction.new(amount: 20, transaction_type: 'debit', source_wallet: source_wallet, target_wallet: target_wallet)
    end
  end

  describe 'callbacks' do
    it 'updates wallet balances correctly on create' do
      transaction = Transaction.new(amount: 30, transaction_type: 'credit', target_wallet: target_wallet)
      expect { transaction.save }.to change { target_wallet.reload.balance }.by(30)

      transaction = Transaction.new(amount: 20, transaction_type: 'debit', source_wallet: source_wallet)
      expect { transaction.save }.to change { source_wallet.reload.balance }.by(-20)
    end

    it 'does not allow debit transaction if source wallet has insufficient balance' do
      Transaction.new(amount: 120, transaction_type: 'debit', source_wallet: source_wallet)
    end
  end
end
