class Deletenull < ActiveRecord::Migration[8.0]
  def change
    change_column_null :ice_creams, :name, false
    change_column_null :reviews, :content, false
    change_column_null :tags, :name, false
    change_column_null :charts, :sweetness, false
    change_column_null :charts, :freshness, false
    change_column_null :charts, :richness, false
    change_column_null :charts, :calorie, false
    change_column_null :charts, :ingredient_richness, false
  end
end
