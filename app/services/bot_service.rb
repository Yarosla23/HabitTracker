require 'telegram/bot'

class BotService
  TOKEN = '7657188677:AAGqQRYT4Qt2RA6kDaYyWklD_KmAaUNvsQQ'

  def initialize
    @bot = Telegram::Bot::Client.new(TOKEN)
  end

  def start
    @bot.listen do |message|
      case message.text
      when '/start'
        handle_start(message)
      when '/habits'
        handle_set_habit_time(message)
      else
        send_message(message.chat.id, "Неизвестная команда. Напишите /start.")
      end
    end
  end

  private

  def handle_start(message)
    chat_id = message.chat.id
    user = User.find_by(chat_id: chat_id)
    if user
      user.update(chat_id: chat_id, telegram_token: nil)
      send_message(chat_id, "Здравствуйте! Начнем отслеживать задачи?")
    else
      send_message(chat_id, "Токен недействителен. Попробуйте снова.")
    end
  end

  def handle_set_habit_time(message)
    chat_id = message.chat.id
    user = User.find_by(chat_id: chat_id)

    if user
      habits = user.habits
      if habits.any?
        send_message(chat_id, "Выберите привычку, для которой нужно установить время уведомления:")
        habits.each_with_index do |habit, index|
          send_message(chat_id, "#{index + 1}. #{habit.title}")
        end
        @bot.listen do |habit_message|
          habit_index = habit_message.text.to_i - 1
          if habits[habit_index]
            send_message(chat_id, "Введите время для уведомления в формате 'HH:MM'.")
            @bot.listen do |time_message|
              if valid_time?(time_message.text)
          binding.irb

                habit = habits[habit_index]
                habit.update!(send_at: Time.parse(time_message.text))
                send_message(chat_id, "Время уведомления для привычки '#{habit.title}' установлено на #{time_message.text}.")
                break
              else
                send_message(chat_id, "Неверный формат времени. Попробуйте снова.")
              end
            end
          else
            send_message(chat_id, "Неверный выбор. Попробуйте снова.")
          end
        end
      else
        send_message(chat_id, "У вас нет привычек, для которых можно установить уведомление.")
      end
    else
      send_message(chat_id, "Вы не зарегистрированы. Используйте /start для регистрации.")
    end
  end

  def valid_time?(text)
    text =~ /\A[0-2]?[0-9]:[0-5][0-9]\z/
  end

  def send_message(chat_id, text)
    @bot.api.send_message(chat_id: chat_id, text: text)
  end
end