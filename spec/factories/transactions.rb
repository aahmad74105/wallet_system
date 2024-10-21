# frozen_string_literal: true

FactoryBot.define do
  factory :transaction do
    amount { 100.0 }
    source_wallet_id { nil } # Adjust as necessary
    target_wallet_id { nil } # Adjust as necessary
    transaction_type { 'deposit' } # Adjust as necessary
  end
end
