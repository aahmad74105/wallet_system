# frozen_string_literal: true

# this is CreateTransactions Migration
class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.decimal :amount
      t.integer :source_wallet_id
      t.integer :target_wallet_id
      t.string :transaction_type

      t.timestamps
    end
  end
end
