# frozen_string_literal: true

class CreateEpisodes < ActiveRecord::Migration[6.0]
  def change
    create_table :episodes do |t|
      t.references :content, null: false, foreign_key: true
      t.string :title, null: false
      t.text :plot, null: false
      t.integer :number, null: false

      t.timestamps
    end
  end
end
