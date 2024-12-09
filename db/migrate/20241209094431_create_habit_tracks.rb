class CreateHabitTracks < ActiveRecord::Migration[7.0]
  def change
    create_table :habit_tracks do |t|
      t.references :habit, null: false, foreign_key: true
      t.boolean :completed
      t.date :date

      t.timestamps
    end
  end
end
