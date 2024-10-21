# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Wallet, type: :model do
  let!(:user) { create(:user) } # Ensure you have a user factory
  let!(:wallet) { create(:wallet, user: user, balance: 1000) }

  describe 'associations' do
    it 'belongs to user' do
      association = Wallet.reflect_on_association(:user)
      expect(association.macro).to eq(:belongs_to)
    end

    it 'has many transactions' do
      association = Wallet.reflect_on_association(:transactions)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:dependent]).to eq(:destroy)
    end

    it 'has many target transactions' do
      association = Wallet.reflect_on_association(:target_transactions)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:class_name]).to eq('Transaction')
      expect(association.options[:dependent]).to eq(:destroy)
    end
  end

  describe 'validations' do
    it 'is valid with a balance greater than or equal to 0' do
      wallet = Wallet.new(user: user, balance: 500)
      expect(wallet).to be_valid
    end

    it 'is not valid without a balance' do
      wallet = Wallet.new(user: user, balance: nil)
      expect(wallet).not_to be_valid
      expect(wallet.errors[:balance]).to include("can't be blank")
    end

    it 'is not valid with a balance less than 0' do
      wallet = Wallet.new(user: user, balance: -100)
      expect(wallet).not_to be_valid
      expect(wallet.errors[:balance]).to include('must be greater than or equal to 0')
    end
  end
end
