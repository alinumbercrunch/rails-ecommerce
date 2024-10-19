class RenameUserProductsToProducts < ActiveRecord::Migration[7.2]
  def change
      rename_table :user_products, :products
  end
end
