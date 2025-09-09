class AddForeignkeyToIcecreams < ActiveRecord::Migration[8.0]
  def change
    add_reference :ice_creams, :admin, foreign_key: true, null: true
    change_column_null :ice_creams, :user_id, true
  end
end
