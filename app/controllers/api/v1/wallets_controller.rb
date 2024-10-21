# frozen_string_literal: true

module Api
  module V1
    # this is WalletsController
    class WalletsController < ApplicationController
      def show
        wallet = Wallet.find(params[:id])
        render json: wallet, status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Wallet not found' }, status: :not_found
      end

      def update
        wallet = Wallet.find_by(id: params[:id])
        if wallet.nil?
          render json: { error: 'Wallet not found' }, status: :not_found
          return
        end

        if wallet.update(wallet_params)
          render json: wallet, status: :ok
        else
          render json: { errors: wallet.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def wallet_params
        params.require(:wallet).permit(:balance)
      end
    end
  end
end
