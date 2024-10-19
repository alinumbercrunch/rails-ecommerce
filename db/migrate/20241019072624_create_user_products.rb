class CreateUserProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :user_products do |t|
      t.string :name
      t.text :description
      t.integer :price
      t.references :category, null: false, foreign_key: true
      t.boolean :active

      t.timestamps
    end
  end
end