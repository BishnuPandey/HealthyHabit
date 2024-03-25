class WorkoutPlanService
  attr_reader :step, :content, :current_user

  def initialize(content, user)
    @content = content
    @current_user = user
  end

  def call
    return [get_step, get_step_total] if set_content
    result = [false, get_content]
    delete_cache
    result
  end

  def set_content
    if get_content.nil?
      set_step_total
      content_data = [JSON.parse(content.to_json)]
    else
      content_data = eval(get_content).push(JSON.parse(content.to_json))
    end
    $redis.set(content_name, content_data)
    set_step

    return false if get_step.to_i > get_step_total.to_i

    true
  end

  def get_content
    $redis.get(content_name)
  end

  def content_name
    "content_#{current_user}"
  end

  def set_step_total
    weight_loss_max_steps = Option.where(form_name: 'weight-loss').maximum(:step)
    $redis.set(step_total, weight_loss_max_steps)
  end

  def get_step_total
    $redis.get(step_total)
  end

  def step_total
    "step_total_#{current_user}"
  end

  def set_step
    if get_step.nil?
      $redis.set(step, 2)
    else
      $redis.set(step, get_step.to_i + 1)
    end
  end

  def get_step
    $redis.get(step)
  end

  def step
    "step_#{current_user}"
  end

  def delete_cache
    $redis.del(step, step_total, content_name)
  end
end
