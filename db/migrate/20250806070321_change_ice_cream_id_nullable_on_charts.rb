class ChangeIceCreamIdNullableOnCharts < ActiveRecord::Migration[8.0]
  def change
    change_column_null :charts, :ice_cream_id, true
  end
end
