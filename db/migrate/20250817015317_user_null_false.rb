class UserNullFalse < ActiveRecord::Migration[8.0]
  def change
    change_column_null :ice_creams, :user_id, false
  end
end
