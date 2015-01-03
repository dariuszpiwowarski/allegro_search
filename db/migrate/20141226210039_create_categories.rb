class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.integer :parent
      t.integer :position
      t.boolean :is_product_catalogue_enabled

      t.timestamps
    end
  end
end
