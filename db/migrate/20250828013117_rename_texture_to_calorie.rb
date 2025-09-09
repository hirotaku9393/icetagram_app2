class RenameTextureToCalorie < ActiveRecord::Migration[8.0]
  def change
    rename_column :charts, :texture, :calorie
  end
end
