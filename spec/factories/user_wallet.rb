# frozen_string_literal: true

FactoryBot.define do
  factory :user_wallet do
    user
    balance { 0.00 } # Default balance
  end
end
