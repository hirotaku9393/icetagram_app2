class AddChartTypeToCharts < ActiveRecord::Migration[8.0]
  def change
    add_column :charts, :chart_type, :string, null: false, default: "official"
  end
end
