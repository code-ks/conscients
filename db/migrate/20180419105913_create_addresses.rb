class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :first_name
      t.string :last_name
      t.string :company
      t.string :address_1
      t.string :address_2
      t.string :city
      t.string :zip_code
      t.string :country, default: "France"
      t.string :title
      t.integer :address_type, default: 0, null: false
      t.string :email
      t.references :client, foreign_key: true

      t.timestamps
    end
    add_index :addresses, :address_type
  end
end
