class AddChatIdAndTelegramTokenAndSendAtToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :chat_id, :bigint
    add_column :users, :telegram_token, :string
  end
end
