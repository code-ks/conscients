class CreateLineItems < ActiveRecord::Migration[5.2]
  def change
    create_table :line_items do |t|
      t.references :product_sku, foreign_key: true
      t.references :order, foreign_key: true
      t.monetize :ttc_price, null: false
      t.monetize :ht_price, null: false
      t.references :tree_plantation, foreign_key: true
      t.integer :quantity, null: false, default: 0
      t.string :recipient_name
      t.text :recipient_message
      t.date :certificate_date
      t.string :certificate_number
      t.string :delivery_email

      t.timestamps
    end
  end
end
