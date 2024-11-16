class CreateHabits < ActiveRecord::Migration[7.0]
  def change
    create_table :habits do |t|
      t.string :title
      t.text :description
      t.string :tags
      t.string :image

      t.timestamps
    end
  end
end
