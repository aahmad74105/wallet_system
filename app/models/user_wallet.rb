# frozen_string_literal: true

# app/models/user_wallet.rb
class UserWallet < Wallet
  belongs_to :user
  validates :balance, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
