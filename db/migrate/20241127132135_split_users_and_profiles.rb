class SplitUsersAndProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.integer :user_id, null: false, foreign_key: true, index: true
      t.date :birthday_date
      t.string :avatar
      t.string :username
      t.text :options

      t.timestamps
    end

    reversible do |data|
      data.up do
        User.find_each do |user|
          Profile.create!(
            user_id: user.id,
            birthday_date: user.birthday_date,
            avatar: user.avatar,
            username: user.username,
            options: user.options
          )
        end
      end
    end

    remove_column :users, :birthday_year, :integer
    remove_column :users, :birthday_date, :date
    remove_column :users, :avatar, :string
    remove_column :users, :username, :string
    remove_column :users, :options, :text

  end
end
