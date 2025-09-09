class AddTasteValuesToIceCreams < ActiveRecord::Migration[8.0]
  def change
    add_column :ice_creams, :sweetness, :integer
    add_column :ice_creams, :freshness, :integer
    add_column :ice_creams, :richness, :integer
    add_column :ice_creams, :texture, :integer
    add_column :ice_creams, :ingredient_richness, :integer
  end
end
