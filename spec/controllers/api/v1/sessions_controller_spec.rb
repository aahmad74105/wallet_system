# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::SessionsController, type: :request do
  describe 'POST /api/v1/login' do
    context 'with valid credentials' do
      let(:valid_params) { { username: 'user', password: 'password' } }

      it 'logs in successfully' do
        post '/api/v1/login', params: valid_params
      end
    end

    context 'with invalid credentials' do
      let(:invalid_params) { { username: 'wrong', password: 'incorrect' } }

      it 'returns unauthorized status' do
        post '/api/v1/login', params: invalid_params
      end
    end
  end
end
