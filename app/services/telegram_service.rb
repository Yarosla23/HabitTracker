require 'telegram/bot'

class TelegramService
  TOKEN = '7657188677:AAGqQRYT4Qt2RA6kDaYyWklD_KmAaUNvsQQ'

  def self.send_message(chat_id, text)
    bot = Telegram::Bot::Client.new(TOKEN)
    bot.api.send_message(chat_id: chat_id, text: text)
  end

  def self.register_user(chat_id, user)
    return if user.chat_id == chat_id # Не обновляем, если уже зарегистрирован
    user.update(chat_id: chat_id)
  end
end
