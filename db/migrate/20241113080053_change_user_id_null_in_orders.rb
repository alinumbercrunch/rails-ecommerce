class ChangeUserIdNullInOrders < ActiveRecord::Migration[7.2]
  def change
    change_column_null :orders, :user_id, true
  end
end
