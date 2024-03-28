# frozen_string_literal: true

class WorkoutPlan < ApplicationRecord
  belongs_to :user
  attr_accessor :question
end
