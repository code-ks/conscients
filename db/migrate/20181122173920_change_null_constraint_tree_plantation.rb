class ChangeNullConstraintTreePlantation < ActiveRecord::Migration[5.2]
  def change
    reversible do |dir|
      dir.up do
        change_column :tree_plantations, :plantation_uuid, :string, null: true
        change_column :tree_plantations, :tree_specie, :string, null: true
        change_column :tree_plantations, :producer_name, :string, null: true
      end
      dir.down do
        change_column :tree_plantations, :plantation_uuid, :string, null: false
        change_column :tree_plantations, :tree_specie, :string, null: false
        change_column :tree_plantations, :producer_name, :string, null: false
      end
    end
  end
end
