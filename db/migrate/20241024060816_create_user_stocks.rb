class CreateUserStocks < ActiveRecord::Migration[7.2]
  def change
    create_table :user_stocks do |t|
      t.references :product, null: false, foreign_key: true
      t.integer :amount
      t.string :size

      t.timestamps
    end
  end
end
