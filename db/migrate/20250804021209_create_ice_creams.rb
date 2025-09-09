class CreateIceCreams < ActiveRecord::Migration[8.0]
  def change
    create_table :ice_creams do |t|
      t.string :name
      t.text :comment
      t.string :image_url

      t.timestamps
    end
  end
end
