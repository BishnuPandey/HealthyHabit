# frozen_string_literal: true

class CreateWorkoutPlans < ActiveRecord::Migration[7.2]
  def change
    create_table :workout_plans do |t|
      t.json :content

      t.timestamps
    end
  end
end
