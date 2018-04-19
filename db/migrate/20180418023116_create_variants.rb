class CreateVariants < ActiveRecord::Migration[5.2]
  def change
    create_table :variants do |t|
      t.integer :category, default: 0, null: false
      t.string :value

      t.timestamps
    end
  end
end
