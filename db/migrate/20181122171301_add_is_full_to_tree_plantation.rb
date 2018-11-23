class AddIsFullToTreePlantation < ActiveRecord::Migration[5.2]
  def change
    add_column :tree_plantations, :is_full, :boolean, default: false
  end
end
