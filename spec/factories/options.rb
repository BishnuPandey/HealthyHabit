# frozen_string_literal: true

FactoryBot.define do
  factory :option do
    question { 'What is your weight?' }
    options { '{Less than 30, 30-45, 45-60, Above 60}' }
  end
end
