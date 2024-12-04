class Habit < ApplicationRecord
    belongs_to :user

    validates :title, presence: true

    # Метод для отправки уведомления пользователю через Telegram
    def send_notification
      return unless send_at && send_at <= Time.current

      TelegramService.send_message(user.chat_id, "Напоминаю, что вам нужно выполнить привычку: #{name}")
      update!(send_at: send_at + 1.day)  # Если нужно повторять каждый день, обновляем send_at
    end

end
