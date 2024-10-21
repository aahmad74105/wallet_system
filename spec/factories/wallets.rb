# frozen_string_literal: true

# spec/factories/wallets.rb
FactoryBot.define do
  factory :wallet do
    balance { 100.00 }
    association :user
  end
end
