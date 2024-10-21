# frozen_string_literal: true

module Api
  module V1
    # this is TransactionsController
    class TransactionsController < ApplicationController
      def create
        transaction = Transaction.new(transaction_params)

        if transaction.save
          render json: { message: 'Transaction created successfully', transaction: transaction }, status: :created
        else
          render json: { errors: transaction.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def transaction_params
        params.require(:transaction).permit(:amount, :source_wallet_id, :target_wallet_id, :transaction_type)
      end
    end
  end
end
