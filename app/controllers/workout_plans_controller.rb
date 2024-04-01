# frozen_string_literal: true

class WorkoutPlansController < ApplicationController
  before_action :authenticate_user!

  def new
    @workout_plan = WorkoutPlan.new
    @workout_plan_form = WorkoutPlanForm.new({}, current_user)
    option = Option.where(form_name: 'weight-loss', step: 1).first
    respond_to do |format|
      format.html { render :new, locals: { option: option } }
    end
  end

  def create
    params.permit!
    @workout_plan = WorkoutPlan.new(params[:workout_plan])
    @workout_plan_form = WorkoutPlanForm.new(workout_plan_params, current_user)

    res = @workout_plan_form.save
    if (!res.nil? == res) && res
      redirect_to workout_plans_path, notice: 'Your information submitted. System will create plan soon.' and return
    else
      status = :unprocessable_entity
    end

    step = HhApp.redis.get("step_#{current_user.id}") || 1
    option = Option.where(form_name: 'weight-loss', step: step).first
    render :new, locals: { option: option }, status: status || :ok
  end

  def index
    @workout_plans = WorkoutPlan
                     .where(user_id: current_user.id)
                     .includes(:user)
                     .order(id: :desc)
                     .all
  end

  private

  def workout_plan_params
    params.require(:workout_plan).permit(:content, :question)
  end
end
