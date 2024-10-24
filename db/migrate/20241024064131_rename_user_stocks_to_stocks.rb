class RenameUserStocksToStocks < ActiveRecord::Migration[7.2]
  def change
    rename_table :user_stocks, :stocks
  end
end
