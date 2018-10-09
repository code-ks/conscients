class AddHomeDisplayToCategory < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :home_display, :integer
  end
end
