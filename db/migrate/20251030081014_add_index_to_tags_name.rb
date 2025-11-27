class AddIndexToTagsName < ActiveRecord::Migration[8.0]
  def change
    add_index :tags, :name
  end
end
