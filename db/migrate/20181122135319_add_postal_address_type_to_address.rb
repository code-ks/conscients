class AddPostalAddressTypeToAddress < ActiveRecord::Migration[5.2]
  def change
    add_column :addresses, :postal_address_type, :integer
  end
end
