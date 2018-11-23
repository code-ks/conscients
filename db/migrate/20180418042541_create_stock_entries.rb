class CreateStockEntries < ActiveRecord::Migration[5.2]
  def change
    create_table :stock_entries do |t|
      t.references :product_sku, foreign_key: true
      t.integer :quantity, null: false

      t.timestamps
    end
  end
end
