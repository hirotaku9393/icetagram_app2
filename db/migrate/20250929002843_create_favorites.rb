class CreateFavorites < ActiveRecord::Migration[8.0]
  def change
    create_table :favorites do |t|
      t.references :user, null: false, foreign_key: true
      t.references :ice_cream, null: false, foreign_key: true
      t.index [ :user_id, :ice_cream_id ], unique: true

      t.timestamps
    end
  end
end
