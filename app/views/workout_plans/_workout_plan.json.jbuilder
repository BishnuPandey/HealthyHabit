# frozen_string_literal: true

json.extract! workout_plan, :id, :content, :created_at, :updated_at
json.url workout_plan_url(workout_plan, format: :json)
