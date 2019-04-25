class LiftNullConstraintsFromTreePlantations < ActiveRecord::Migration[5.2]
  def change
    change_column_null :tree_plantations, :plantation_uuid, true
    change_column_null :tree_plantations, :tree_specie, true
    change_column_null :tree_plantations, :producer_name, true
  end
end
