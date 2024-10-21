# frozen_string_literal: true

# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    subject { User.new(name: name, email: email, password: password) }

    let(:name) { 'John Doe' }
    let(:email) { 'john.doe@example.com' }
    let(:password) { 'password123' }

    context 'when all attributes are valid' do
      it 'is valid' do
        expect(subject).to be_valid
      end
    end

    context 'when name is nil' do
      let(:name) { nil }

      it 'is not valid' do
        expect(subject).to_not be_valid
        expect(subject.errors[:name]).to include("can't be blank")
      end
    end

    context 'when email is nil' do
      let(:email) { nil }

      it 'is not valid' do
        expect(subject).to_not be_valid
        expect(subject.errors[:email]).to include("can't be blank")
      end
    end

    context 'when email is not unique' do
      before { User.create(name: 'Jane Doe', email: email, password: 'password123') }

      it 'is not valid' do
        expect(subject).to_not be_valid
        expect(subject.errors[:email]).to include('has already been taken')
      end
    end

    context 'when email format is invalid' do
      let(:email) { 'invalid_email' }

      it 'is not valid' do
        expect(subject).to_not be_valid
        expect(subject.errors[:email]).to include('is invalid')
      end
    end

    context 'when password is nil' do
      let(:password) { nil }

      it 'is not valid' do
        expect(subject).to_not be_valid
        expect(subject.errors[:password]).to include("can't be blank")
      end
    end

    context 'when password is too short' do
      let(:password) { 'short' }

      it 'is not valid' do
        expect(subject).to_not be_valid
        expect(subject.errors[:password]).to include('is too short (minimum is 6 characters)')
      end
    end
  end

  describe 'callbacks' do
    it 'creates a user wallet after user is created' do
      user = User.create(name: 'Alice', email: 'alice@example.com', password: 'password123')
      expect(user.user_wallet).to be_present
      expect(user.user_wallet.balance).to eq(0.00)
    end
  end
end
