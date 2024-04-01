# frozen_string_literal: true

FactoryBot.define do
  factory :workout_plan do
    
    content {[{
        'question' => 'Question 1',
        'content' => '1'
      }]}
    user_id { nil }
  end
end
