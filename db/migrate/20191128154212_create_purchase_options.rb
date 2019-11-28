# frozen_string_literal: true

class CreatePurchaseOptions < ActiveRecord::Migration[6.0]
  def change
    create_table :purchase_options do |t|
      t.references :content, null: false, foreign_key: true
      t.string :quality, null: false
      t.integer :price, null: false

      t.timestamps
    end
  end
end
