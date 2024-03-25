# frozen_string_literal: true

class AddUserRefToWorkoutPlans < ActiveRecord::Migration[7.2]
  def change
    add_reference :workout_plans, :user, null: false, foreign_key: true
    add_index :workout_plans, :user_id, unique: true
  end
end
