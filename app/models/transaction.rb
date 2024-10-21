# frozen_string_literal: true

# this is Transaction
class Transaction < ApplicationRecord
  belongs_to :source_wallet, class_name: 'Wallet', optional: true
  belongs_to :target_wallet, class_name: 'Wallet', optional: true

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :transaction_type, inclusion: { in: %w[credit debit] }

  # validate :validate_wallets
  # validate :sufficient_balance, if: -> { transaction_type == 'debit' }

  private

  def validate_wallets
    if transaction_type == 'credit' && source_wallet.present?
      errors.add(:source_wallet, 'must be nil for credits')
    elsif transaction_type == 'debit' && target_wallet.present?
      errors.add(:target_wallet, 'must be nil for debits')
    end
  end

  # Add a callback to update wallet balances after save
  after_create :update_wallet_balances

  def update_wallet_balances
    ActiveRecord::Base.transaction do
      if transaction_type == 'credit'
        target_wallet.increment!(:balance, amount)
      elsif transaction_type == 'debit'
        source_wallet.decrement!(:balance, amount)
      end
    end
  end
end
