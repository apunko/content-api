# frozen_string_literal: true

class AddNotNullConstraintsToContent < ActiveRecord::Migration[6.0]
  def change
    change_column_null :contents, :title, null: false
    change_column_null :contents, :plot, null: false
  end
end
