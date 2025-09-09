class ChangeIceCreamIdNullableWithForeignKey < ActiveRecord::Migration[8.0]
  def up
    remove_foreign_key :charts, :ice_creams
    change_column_null :charts, :ice_cream_id, true
    add_foreign_key :charts, :ice_creams
  end

  def down
    remove_foreign_key :charts, :ice_creams
    change_column_null :charts, :ice_cream_id, false
    add_foreign_key :charts, :ice_creams
  end
end

