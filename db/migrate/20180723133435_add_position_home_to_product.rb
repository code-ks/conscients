class AddPositionHomeToProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :position_home, :integer
  end
end
