# frozen_string_literal: true

class WorkoutPlansController < ApplicationController
  before_action :authenticate_user!

  def new
    @workout_plan = WorkoutPlan.new
    option = Option.where(form_name: 'weight-loss', step: 1).first
    respond_to do |format|
      format.html { render :new, locals: { option: option } }
    end
  end

  def create
    params.permit!
    @workout_plan = WorkoutPlan.new(params[:workout_plan])
    @workout_plan.user_id = current_user.id
    step = $redis.get("step_#{current_user.id}") || 1
    option = Option.where(form_name: 'weight-loss', step: step).first

    respond_to do |format|
      if @workout_plan.valid?
        @workout_plan_form = WorkoutPlanForm.new(workout_plan_params, current_user.id)
        step, total_step = @workout_plan_form.save
        if !step
          @workout_plan.content = total_step
          if @workout_plan.save
            flash[:type] = :success
            flash[:message] = 'Your information submitted. System will create plan soon.'
            format.html { redirect_to(@workout_plan) }
          else
            flash[:type] = :error
            flash[:message] = 'Unable to submit your information. Please try again.'
            format.html { redirect_to(workout_plans_path) }
          end
        else
          step_next = step || 1
          option = Option.where(form_name: 'weight-loss', step: step_next).first
          @workout_plan = WorkoutPlan.new
        end
      end
      format.html { render :new, locals: { option: option } }
    end
  end

  def index
    @workout_plans = WorkoutPlan
                     .includes(:user)
                     .order(id: :desc)
                     .all
  end

  private

  def workout_plan_params
    params.require(:workout_plan).permit(:content, :question)
  end

  def workout_plan_step_check; end
end
