class CreateJoinTableProductsSubCategories < ActiveRecord::Migration[5.2]
  def change
    create_join_table :products, :sub_categories do |t|
      # t.index [:product_id, :sub_category_id]
      # t.index [:sub_category_id, :product_id]
    end
  end
end
