class AddUsersAttributes < ActiveRecord::Migration[7.0]
    def change
      add_column :users, :username, :string
      add_column :users, :birthday_date, :date
      add_column :users, :options, :text
    end
end
