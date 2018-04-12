class CreateCategorizations < ActiveRecord::Migration[5.2]
  def change
    create_table :categorizations do |t|
      t.references :sub_category, foreign_key: true
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
