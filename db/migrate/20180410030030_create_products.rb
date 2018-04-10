class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.monetize :ht_price
      t.decimal :taxe_rate, precision: 4, scale: 2, default: 20
      t.integer :weight, default: 0
      t.integer :product_type, default: 0
      t.boolean :published, default: true
      t.integer :display_order
      t.monetize :ht_buying_price
      t.string :seo_title
      t.string :meta_description
      t.text :keywords, array: true, default: []
      t.string :url
      t.decimal :producer_latitude, precision: 11, scale: 8
      t.decimal :producer_longitude, precision: 11, scale: 8

      t.timestamps
    end
  end
end
