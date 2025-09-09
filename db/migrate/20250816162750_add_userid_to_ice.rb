class AddUseridToIce < ActiveRecord::Migration[8.0]
  def change
    add_reference :ice_creams, :user, null: true, foreign_key: true
  end
end
