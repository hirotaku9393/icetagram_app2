class AddDbConstraints < ActiveRecord::Migration[8.0]
  def change
    # favoritesの複合ユニーク制約を追加
    add_index :favorites, [ :user_id, :ice_cream_id ], unique: true

    # tagsのユニーク制約を追加
    remove_index :tags, :name
    add_index :tags, :name, unique: true
  end
end
