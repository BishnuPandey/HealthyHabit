# frozen_string_literal: true

json.array! @workout_plans, partial: 'workout_plans/workout_plan', as: :workout_plan
