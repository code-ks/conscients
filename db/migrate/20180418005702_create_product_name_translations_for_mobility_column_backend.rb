class CreateProductNameTranslationsForMobilityColumnBackend < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :name_en, :string
    add_index  :products, :name_en
    add_column :products, :name_fr, :string
    add_index  :products, :name_fr
    remove_column :products, :name
  end
end
