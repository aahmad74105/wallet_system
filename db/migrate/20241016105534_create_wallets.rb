# frozen_string_literal: true

# this is CreateWallets Migration
class CreateWallets < ActiveRecord::Migration[7.1]
  def change
    create_table :wallets do |t|
      t.string :type
      t.decimal :balance

      t.timestamps
    end
  end
end
