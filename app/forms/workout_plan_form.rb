# frozen_string_literal: true

class WorkoutPlanForm
  include ActiveModel::Model
  attr_accessor :content, :current_user
  validate :content_presence
  validate :one_plan_per_user

  def initialize(content, user)
    @content = content
    @current_user = user
  end

  def save
    return false if invalid?
    step, total_step = WorkoutPlanService.new(content, current_user.id).call
    return step if step && (step.to_i <= total_step.to_i)
    WorkoutPlan.create(
      user_id: current_user.id, 
      content: total_step
      )
    true
  end

  private

  def content_answered? 
    !content[:content].nil?
  end

  def content_presence
    unless content_answered?
      errors.add(:content, ": please answer question")
    end  
  end

  def one_plan_per_user
    if current_user.workout_plan && current_user.workout_plan != self
      errors.add(:user, "already has a plan")
    end
  end

end
