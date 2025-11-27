class AddUserIdToCharts < ActiveRecord::Migration[8.0]
  def change
    add_reference :charts, :user, foreign_key: true
  end
end
