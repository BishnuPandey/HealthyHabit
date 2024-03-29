# frozen_string_literal: true

class WorkoutPlanService
  def initialize(content, user)
    @content = content
    @current_user = user
    @redis = HhApp.redis
  end

  def call
    return [fetch_step, fetch_step_total] if add_content

    result = [false, fetch_content]
    delete_cache
    result
  end

  def add_content
    if fetch_content.nil?
      add_step_total
      content_data = [JSON.parse(@content.to_json)]
    else
      content_data = eval(fetch_content).push(JSON.parse(@content.to_json))
    end
    @redis.set(content_name, content_data)
    add_step
    return false if fetch_step.to_i > fetch_step_total.to_i

    true
  end

  def fetch_content
    @redis.get(content_name)
  end

  def content_name
    "content_#{@current_user}"
  end

  def add_step_total
    weight_loss_max_steps = Option.where(form_name: 'weight-loss').maximum(:step)
    @redis.set(step_total, weight_loss_max_steps)
  end

  def fetch_step_total
    @redis.get(step_total)
  end

  def step_total
    "step_total_#{@current_user}"
  end

  def add_step
    if fetch_step.nil?
      @redis.set(step, 2)
    else
      @redis.set(step, fetch_step.to_i + 1)
    end
  end

  def fetch_step
    @redis.get(step)
  end

  def step
    "step_#{@current_user}"
  end

  def delete_cache
    @redis.del(step, step_total, content_name)
  end
end
