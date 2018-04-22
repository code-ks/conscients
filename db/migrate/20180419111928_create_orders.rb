class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :aasm_state, null: false
      t.references :coupon, foreign_key: true
      t.references :delivery_address
      t.references :billing_address
      t.integer :delivery_method, null: false, default: 0
      t.monetize :delivery_fees
      t.monetize :total_price
      t.integer :payment_method, null: false, default: 0
      t.text :recipient_message
      t.text :customer_note
      t.references :client, foreign_key: true

      t.timestamps
    end
    add_foreign_key :orders, :addresses, column: :delivery_address_id, primary_key: :id
    add_foreign_key :orders, :addresses, column: :billing_address_id, primary_key: :id
  end
end
