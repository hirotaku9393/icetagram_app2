class AddCalorieValueToIceCreams < ActiveRecord::Migration[8.0]
  def change
    add_column :ice_creams, :calorie_value, :integer
  end
end
