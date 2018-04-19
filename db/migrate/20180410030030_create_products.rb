class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.monetize :ht_price, null: false
      t.decimal :tax_rate, precision: 4, scale: 2, default: 20, null: false
      t.integer :weight, default: 0
      t.integer :product_type, default: 0, null: false
      t.boolean :published, default: true, null: false
      t.integer :position
      t.monetize :ht_buying_price
      t.string :seo_title
      t.string :meta_description
      t.text :keywords, array: true, default: []
      t.string :slug
      t.decimal :producer_latitude, precision: 11, scale: 8
      t.decimal :producer_longitude, precision: 11, scale: 8

      t.timestamps
    end
    add_index :products, :slug, unique: true
    add_index :products, :weight
    add_index :products, :ht_price_cents
    add_index :products, :tax_rate
  end
end
