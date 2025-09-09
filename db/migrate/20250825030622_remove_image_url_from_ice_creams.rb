class RemoveImageUrlFromIceCreams < ActiveRecord::Migration[8.0]
  def change
    remove_column :ice_creams, :image_url, :string
  end
end
