# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'workout_plans/show', type: :view do
  before do
    assign(:workout_plan, WorkoutPlan.create!(
                            content: ''
                          ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(//)
  end
end
