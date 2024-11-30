class AddSendAtToHabits < ActiveRecord::Migration[7.0]
  def change
    add_column :habits, :send_at, :datetime
  end
end
