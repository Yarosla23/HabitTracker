
if Rails.env.production?
  Thread.new do
    begin
      bot_service = BotService.new
      bot_service.start
    rescue => e
      Rails.logger.error "Ошибка при запуске Telegram-бота: #{e.message}"
    end
  end
end
