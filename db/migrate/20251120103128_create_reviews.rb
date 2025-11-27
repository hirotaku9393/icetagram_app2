class CreateReviews < ActiveRecord::Migration[8.0]
  def change
    create_table :reviews do |t|
      t.text :content
      t.references :user, null: false, foreign_key: true
      t.references :ice_cream, null: false, foreign_key: true

      t.timestamps
    end
  end
end
