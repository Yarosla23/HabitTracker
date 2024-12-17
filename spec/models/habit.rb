require 'rails_helper'

RSpec.describe Habit, type: :model do
  # Association tests
  it { should belong_to(:user) }
  it { should have_many(:habit_tracks) }
  let(:user) { create(:user) }
  let(:habit) { create(:habit, user: user) }
  # Scope tests
  describe '.completed' do
    
    let!(:completed_habit) { create(:habit, status: 'Выполнена', user: user) }
    let!(:in_progress_habit) { create(:habit, status: 'Выполняется', user: user) }
    
    it 'returns only completed habits' do
      expect(Habit.completed).to include(completed_habit)
      expect(Habit.completed).not_to include(in_progress_habit)
    end
  end

  describe '.in_progress' do
    let!(:completed_habit) { create(:habit, status: 'Выполнена') }
    let!(:in_progress_habit) { create(:habit, status: 'Выполняется') }
    
    it 'returns only in-progress habits' do
      expect(Habit.in_progress).to include(in_progress_habit)
      expect(Habit.in_progress).not_to include(completed_habit)
    end
  end

  describe '.not_performed' do
    let!(:not_performed_habit) { create(:habit, status: 'Не выполняется') }
    let!(:completed_habit) { create(:habit, status: 'Выполнена') }
    
    it 'returns only not-performed habits' do
      expect(Habit.not_performed).to include(not_performed_habit)
      expect(Habit.not_performed).not_to include(completed_habit)
    end
  end

  # Constants tests
  describe 'constants' do
    it 'includes expected TAGS' do
      expect(Habit::TAGS).to match_array([
        'Здоровье',
        'Спорт',
        'Правильное питание',
        'Чтение книг',
        'Продуктивность'
      ])
    end

    it 'includes expected HABIT_IMAGES' do
      expect(Habit::HABIT_IMAGES).to match_array([
        "habit_images/beautiful.png",
        "habit_images/eat.png",
        "habit_images/finance.png",
        "habit_images/ocean.png",
        "habit_images/present.png",
        "habit_images/travel.png"
      ])
    end

    it 'includes expected STATUS' do
      expect(Habit::STATUS).to match_array(['Выполняется', 'Не выполняется', 'Выполнена'])
    end
  end

  # Validation tests
  describe 'validations' do
    let(:habit) { build(:habit) }

    it 'validates presence of title' do
      habit.title = nil
      expect(habit).not_to be_valid
      expect(habit.errors[:title]).to include("can't be blank")
    end

    it 'validates title length' do
      habit.title = 'Short'
      expect(habit).to be_valid

      habit.title = 'A' * 23
      expect(habit).not_to be_valid
      expect(habit.errors[:title]).to include("is too long (maximum is 22 characters)")
    end

    it 'validates inclusion of tags' do
      habit.tags = ['Invalid tag']
      expect(habit).not_to be_valid
      expect(habit.errors[:tags]).to include("is not included in the list")
    end

    it 'validates inclusion of status' do
      habit.status = 'Invalid status'
      expect(habit).not_to be_valid
      expect(habit.errors[:status]).to include("is not included in the list")
    end
  end

  # Class method tests
  describe '.send_notifications' do
    let(:user) { create(:user) }
    let!(:habit) { create(:habit, user: user, send_at: Time.current) }

    it 'sends notifications for habits with send_at <= current time' do
      expect(TelegramService).to receive(:send_message).with(user.chat_id, "Напоминаю, что вам нужно выполнить привычку: #{habit.name}")
      Habit.send_notifications
      expect(habit.reload.send_at).to eq(habit.send_at + 1.day)
    end
  end

  # Instance method tests
  describe '#set_status' do
    let(:habit) { create(:habit, status: 'Выполняется') }

    it 'updates status if new status is valid' do
      habit.set_status('Выполнена')
      expect(habit.status).to eq('Выполнена')
    end

    it 'does not update status if new status is invalid' do
      habit.set_status('Invalid status')
      expect(habit.status).to eq('Выполняется')
      expect(habit.errors[:status]).to include("Invalid status")
    end
  end
end
