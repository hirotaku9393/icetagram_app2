class CreateTodayIces < ActiveRecord::Migration[8.0]
  def change
    create_table :today_ices do |t|
      t.references :ice_cream, null: false, foreign_key: true
      t.string :uuid

      t.timestamps
    end
    add_index :today_ices, :uuid, unique: true
  end
end
