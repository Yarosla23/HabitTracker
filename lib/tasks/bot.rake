namespace :telegram do
  desc "Запуск Telegram бота"
  task start: :environment do
    bot_service = BotService.new
    # Флаг для управления запуском и остановкой
    $running = true

    # Перезапускаем бот в фоновом процессе
    Process.detach(fork do
      bot_service.start
    end)

    # Цикл проверки флага
    while $running
      sleep 1  # Пауза для предотвращения быстрого цикла
    end

    puts "Бот остановлен."
  end

  desc "Остановка Telegram бота"
  task stop: :environment do
    # Меняем флаг на false для остановки бота
    $running = false
    puts "Запуск бота был остановлен."
  end
end
