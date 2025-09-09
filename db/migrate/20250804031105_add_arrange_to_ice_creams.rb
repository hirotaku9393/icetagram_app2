class AddArrangeToIceCreams < ActiveRecord::Migration[8.0]
  def change
    add_column :ice_creams, :arrange, :text
  end
end
