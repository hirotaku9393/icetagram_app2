class RenameTextureToCalorieFromIcecream < ActiveRecord::Migration[8.0]
  def change
    rename_column :ice_creams, :texture, :calorie
  end
end
