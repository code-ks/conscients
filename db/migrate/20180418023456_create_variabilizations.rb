class CreateVariabilizations < ActiveRecord::Migration[5.2]
  def change
    create_table :variabilizations do |t|
      t.references :product_sku, foreign_key: true
      t.references :variant, foreign_key: true

      t.timestamps
    end
  end
end
