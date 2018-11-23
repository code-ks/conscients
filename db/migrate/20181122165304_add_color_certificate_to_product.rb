class AddColorCertificateToProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :color_certificate, :string
    remove_column :tree_plantations, :color_certificate
  end
end
