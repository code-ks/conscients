class CreateCoupons < ActiveRecord::Migration[5.2]
  def change
    create_table :coupons do |t|
      t.references :product, foreign_key: true
      t.references :client, foreign_key: true
      t.boolean :percentage, null: false, default: false
      t.integer :amount, null: false
      t.date :valid_from, null: false
      t.date :valid_until, null: false

      t.timestamps
    end
  end
end
