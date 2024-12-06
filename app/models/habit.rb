class Habit < ApplicationRecord
  belongs_to :user

  TAGS = [
    'Здровье',
    'Спорт',
    'Правильное питание',
    'Чтение книг',
    'Продуктивность'
  ]

  HABIT_IMAGES = [
    "habit_images/beautiful.png",
    "habit_images/eat.png",
    "habit_images/finance.png",
    "habit_images/ocean.png",
    "habit_images/present.png",
    "habit_images/travel.png"
].freeze

  STATUS = ['Выполняется', 'Не выполняется', 'Выполнена']

  validates :title, presence: true, length: { in: 6..22 }
  validates :tags, inclusion: { in: TAGS }
  validates :status, inclusion: { in: STATUS }

  def send_notification
    return unless send_at && send_at <= Time.current

    TelegramService.send_message(user.chat_id, "Напоминаю, что вам нужно выполнить привычку: #{name}")
    update!(send_at: send_at + 1.day)  
  end

  def set_status(new_status)
    binding.irb
    if STATUS.include?(new_status)
      update(status: new_status)
    else
      errors.add(:status, "Invalid status")
    end
  end
  def self.habit_images
    HABIT_IMAGES
  end
end
