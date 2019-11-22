class AddUniqIndexToContentOnTitleAndNumber < ActiveRecord::Migration[6.0]
  def change
    add_index :contents, [:title, :number], unique: true
  end
end
