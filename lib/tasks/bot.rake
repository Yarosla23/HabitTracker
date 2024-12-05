namespace :telegram do
  desc "Запуск Telegram бота"
  task start: :environment do
    bot_service = BotService.new
    $running = true

    Process.detach(fork do
      bot_service.start
    end)

    while $running
      sleep 1  
    end

    puts "Бот остановлен."
  end

  desc "Остановка Telegram бота"
  task stop: :environment do
    $running = false
    puts "Запуск бота был остановлен."
  end
end
