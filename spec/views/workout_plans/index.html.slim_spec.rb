# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'workout_plans/index', type: :view do
  before do
    assign(:workout_plans, [
             WorkoutPlan.create!(
               content: ''
             ),
             WorkoutPlan.create!(
               content: ''
             )
           ])
  end

  it 'renders a list of workout_plans' do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new(''.to_s), count: 2
  end
end
