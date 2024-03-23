# frozen_string_literal: true

class WorkoutPlanForm
  include ActiveModel::Model

  attr_accessor :content, :current_user

  validates :content, presence: true

  def initialize(content, current_user)
    @content = content
    @current_user = current_user
  end

  def save
    return false if invalid?

    step, total_step = WorkoutPlanService.new(content, current_user).call

    return [step, total_step] if step && (step.to_i <= total_step.to_i)

    [step, total_step]
  end
end
