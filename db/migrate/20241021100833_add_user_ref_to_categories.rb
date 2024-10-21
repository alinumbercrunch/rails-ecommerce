class AddUserRefToCategories < ActiveRecord::Migration[7.2]
  def change
    add_reference :categories, :user, foreign_key: true, null: true

    reversible do |dir|
      dir.up do
        # Set a default user reference for existing records
        default_user = User.first_or_create!(email: 'default@example.com', password: 'password', password_confirmation: 'password')
        Category.update_all(user_id: default_user.id)

        # Ensure the column is not null
        change_column_null :categories, :user_id, false
      end
    end
  end
end
