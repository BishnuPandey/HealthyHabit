# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'workout_plans/new', type: :view do
  before do
    assign(:workout_plan, WorkoutPlan.new(
                            content: ''
                          ))
  end

  it 'renders new workout_plan form' do
    render

    assert_select 'form[action=?][method=?]', workout_plans_path, 'post' do
      assert_select 'input[name=?]', 'workout_plan[content]'
    end
  end
end
