require 'rails_helper'

RSpec.describe HabitTracksController, type: :controller do
  let(:user) { create(:user) }
  let(:habit) { create(:habit, user: user) }
  let(:habit_track) { create(:habit_track, habit: habit) }

  before do
    login_as user, scope: :user # Аутентифицируем пользователя для теста
    current_user = user
  end

  describe 'POST #create' do
    context 'with valid parameters' do
        it{binding.irb}
      let(:valid_params) { { habit_id: habit.id, habit_track: { date: Date.today, completed: true } } }

      it 'creates a new habit track' do
        expect {
          post :create, params: valid_params, format: :html
        }.to change { habit.habit_tracks.count }.by(1)
      end

      it 'redirects to the habit page with a success notice' do
        post :create, params: valid_params, format: :html
        expect(response).to redirect_to(habit)
        expect(flash[:notice]).to eq('Habit track added.')
      end

      it 'renders the JS response for successful creation' do
        post :create, params: valid_params, format: :js
        expect(response).to render_template(:create)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) { { habit_id: habit.id, habit_track: { date: nil, completed: true } } }

      it 'does not create a new habit track' do
        expect {
          post :create, params: invalid_params, format: :html
        }.not_to change { habit.habit_tracks.count }
      end

      it 'redirects back to the habit page with an alert' do
        post :create, params: invalid_params, format: :html
        expect(response).to redirect_to(habit)
        expect(flash[:alert]).to eq('Error adding habit track.')
      end

      it 'renders the JS error template' do
        post :create, params: invalid_params, format: :js
        expect(response).to render_template('error.js.erb')
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid parameters' do
      let(:valid_params) { { habit_id: habit.id, id: habit_track.id, habit_track: { completed: false } } }

      it 'updates the habit track' do
        patch :update, params: valid_params, format: :html
        expect(habit_track.reload.completed).to eq(false)
      end

      it 'redirects to the habit page with a success notice' do
        patch :update, params: valid_params, format: :html
        expect(response).to redirect_to(habit)
        expect(flash[:notice]).to eq('Habit track updated.')
      end

      it 'renders the JS response for successful update' do
        patch :update, params: valid_params, format: :js
        expect(response).to render_template(:update)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) { { habit_id: habit.id, id: habit_track.id, habit_track: { date: nil } } }

      it 'does not update the habit track' do
        original_date = habit_track.date
        patch :update, params: invalid_params, format: :html
        expect(habit_track.reload.date).to eq(original_date)
      end

      it 'redirects back to the habit page with an alert' do
        patch :update, params: invalid_params, format: :html
        expect(response).to redirect_to(habit)
        expect(flash[:alert]).to eq('Error updating habit track.')
      end

      it 'renders the JS error template' do
        patch :update, params: invalid_params, format: :js
        expect(response).to render_template('error.js.erb')
      end
    end
  end

  describe 'before_action :set_habit' do
    it 'sets the @habit instance variable' do
      post :create, params: { habit_id: habit.id, habit_track: { date: Date.today, completed: true } }
      expect(assigns(:habit)).to eq(habit)
    end

    it 'raises an error if habit does not belong to the current user' do
      another_user = create(:user)
      another_habit = create(:habit, user: another_user)

      expect {
        post :create, params: { habit_id: another_habit.id, habit_track: { date: Date.today, completed: true } }
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
