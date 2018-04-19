class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :company
      t.string :address_1, null: false
      t.string :address_2
      t.string :city, null: false
      t.string :zip_code, null: false
      t.string :country, null: false, default: "France"
      t.string :title
      t.references :client, foreign_key: true

      t.timestamps
    end
  end
end
