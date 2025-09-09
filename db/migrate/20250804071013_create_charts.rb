class CreateCharts < ActiveRecord::Migration[8.0]
  def change
    create_table :charts do |t|
      t.integer :sweetness
      t.integer :freshness
      t.integer :richness
      t.integer :texture
      t.integer :ingredient_richness
      t.references :ice_cream, null: false, foreign_key: true

      t.timestamps
    end
  end
end
