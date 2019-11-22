# frozen_string_literal: true

class AddUniqIndexToContentOnTitleAndNumber < ActiveRecord::Migration[6.0]
  def change
    add_index :contents, %i[title number], unique: true
  end
end
