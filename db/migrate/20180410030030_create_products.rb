class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.monetize :ht_price, null: false
      t.decimal :tax_rate, precision: 4, scale: 2, default: 20, null: false
      t.integer :weight, default: 0
      t.integer :product_type, default: 0, null: false
      t.boolean :published, default: true, null: false
      t.integer :display_order
      t.monetize :ht_buying_price
      t.string :seo_title, null: false
      t.string :meta_description, null: false
      t.text :keywords, array: true, default: []
      t.string :slug, null: false
      t.decimal :producer_latitude, precision: 11, scale: 8
      t.decimal :producer_longitude, precision: 11, scale: 8

      t.timestamps
    end
    add_index :products, :slug, unique: true
  end
end
