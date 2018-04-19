class CreateProductSkus < ActiveRecord::Migration[5.2]
  def change
    create_table :product_skus do |t|
      t.references :product, foreign_key: true
      t.string :sku, null: false
      t.integer :quantity, default: 0

      t.timestamps
    end
  end
end
