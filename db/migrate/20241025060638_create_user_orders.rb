class CreateUserOrders < ActiveRecord::Migration[7.2]
  def change
    create_table :orders do |t|
      t.string :customer_email
      t.boolean :fullfilled
      t.integer :total
      t.string :address

      t.timestamps
    end
  end
end
