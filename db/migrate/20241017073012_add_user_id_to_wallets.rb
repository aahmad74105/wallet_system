# frozen_string_literal: true

# this is AddUserIdToWallets Migration
class AddUserIdToWallets < ActiveRecord::Migration[7.1]
  def change
    add_column :wallets, :user_id, :integer
  end
end
