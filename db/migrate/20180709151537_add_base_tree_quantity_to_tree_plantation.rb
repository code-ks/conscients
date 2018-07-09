class AddBaseTreeQuantityToTreePlantation < ActiveRecord::Migration[5.2]
  def change
    add_column :tree_plantations, :base_tree_quantity, :integer
  end
end
