# frozen_string_literal: true

class CreatePurchases < ActiveRecord::Migration[6.0]
  def change
    create_table :purchases do |t|
      t.references :user, null: false, foreign_key: true
      t.references :purchase_option, null: false, foreign_key: true
      t.boolean :expired, null: false, default: false
      t.string :expiration_jid

      t.timestamps
    end
  end
end
