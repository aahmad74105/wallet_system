# frozen_string_literal: true

module Api
  module V1
    # this is SessionsController
    class SessionsController < ApplicationController
      def create
        if params[:username] == 'user' && params[:password] == 'password'
          render json: { message: 'Logged in successfully' }, status: :ok
        else
          render json: { error: 'Invalid credentials' }, status: :unauthorized
        end
      end
    end
  end
end
