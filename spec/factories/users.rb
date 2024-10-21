# frozen_string_literal: true

# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    name { 'exampleuser' }
    email { 'user@example.com' }
    password { 'password' }
  end
end
