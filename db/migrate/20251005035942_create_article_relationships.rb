class CreateArticleRelationships < ActiveRecord::Migration[8.0]
  def change
    create_table :ice_cream_relationships do |t|
      t.references :ice_cream, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
    add_index :ice_cream_relationships, [:ice_cream_id, :tag_id], unique: true
  end
end
