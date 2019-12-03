# frozen_string_literal: true

class AddPartialUniqueIndexOnPurchases < ActiveRecord::Migration[6.0]
  def change
    add_index :purchases, %i[user_id content_id], where: 'expired = false', unique: true
  end
end
