class SendNotificationsJob < ApplicationJob
    queue_as :default
  
    def perform
      Habit.where("send_at <= ?", Time.zone.now).find_each do |habit|
        Rails.logger.info("Sending notification for habit #{habit.id} at #{habit.send_at}")
        habit.send_notification
        habit.update(status: 'BOT')  # Обновляем статус привычки
      end
    end
  end
  