class AddOndeleteToCharts < ActiveRecord::Migration[8.0]
  def change
    remove_foreign_key :charts, :ice_creams
    add_foreign_key :charts, :ice_creams, on_delete: :cascade
  end
end
