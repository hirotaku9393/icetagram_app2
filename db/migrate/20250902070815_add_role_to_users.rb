class AddRoleToUsers < ActiveRecord::Migration[8.0]
  def up
    unless column_exists?(:users, :role)
      add_column :users, :role, :integer, default: 0, null: false
    end
  end
  
  def down
    if column_exists?(:users, :role)
      remove_column :users, :role
    end
  end
end
