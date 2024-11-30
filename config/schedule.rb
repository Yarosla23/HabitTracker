# config/schedule.rb
every 1.minute do
  runner "NotificationService.send_notifications"
end
