class AddCanDebugToClients < ActiveRecord::Migration[5.2]
  def change
    add_column :clients, :can_debug, :boolean, null: false, default: false
  end
end
