class AddCertificateCounterToTreePlantations < ActiveRecord::Migration[5.2]
  def change
    add_column :tree_plantations, :certificate_counter, :integer, default: 0, null: false
  end
end
