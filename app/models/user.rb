# frozen_string_literal: true

# this is User model
class User < ApplicationRecord
  has_secure_password # This will handle password hashing and authentication

  # Associations
  has_one :user_wallet, class_name: 'UserWallet', dependent: :destroy

  # Validations
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6 }

  # Callback to create a wallet after the user is created
  after_create :initialize_user_wallet

  private

  def initialize_user_wallet
    UserWallet.create(user: self, balance: 0.00) # Create a new UserWallet with a zero balance
  end
end
