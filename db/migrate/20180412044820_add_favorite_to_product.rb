class AddFavoriteToProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :favorite, :boolean
  end
end
