class AddPositionToVariant < ActiveRecord::Migration[5.2]
  def change
    add_column :variants, :position, :integer
  end
end
