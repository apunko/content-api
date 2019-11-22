# frozen_string_literal: true

class CreateContents < ActiveRecord::Migration[6.0]
  def change
    create_table :contents do |t|
      t.string :title
      t.text :plot
      t.integer :number
      t.string :type

      t.timestamps
    end
  end
end
