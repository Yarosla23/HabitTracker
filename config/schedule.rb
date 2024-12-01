every 1.minute do
  runner "NotificationService.send_notifications"
end
