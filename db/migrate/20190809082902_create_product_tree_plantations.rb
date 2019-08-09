class CreateProductTreePlantations < ActiveRecord::Migration[5.2]
  def change
    create_table :product_tree_plantations do |t|
      t.references :product, foreign_key: true
      t.references :tree_plantation, foreign_key: true

      t.timestamps
    end
  end
end
