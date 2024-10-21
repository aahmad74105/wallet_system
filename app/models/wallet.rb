# frozen_string_literal: true

# this is Wallet model
class Wallet < ApplicationRecord
  belongs_to :user

  self.inheritance_column = :_type_disabled

  has_many :transactions, foreign_key: :source_wallet_id, dependent: :destroy
  has_many :target_transactions, class_name: 'Transaction', foreign_key: :target_wallet_id, dependent: :destroy

  validates :balance, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
