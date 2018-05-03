class CreateCoupons < ActiveRecord::Migration[5.2]
  def change
    create_table :coupons do |t|
      t.references :product, foreign_key: true
      t.references :client, foreign_key: true
      t.integer :percentage
      t.monetize :amount, amount: { null: true, default: nil }
      t.string :name, null: false
      t.monetize :amount_min_order
      t.date :valid_from, null: false
      t.date :valid_until, null: false

      t.timestamps
    end
  end
end
