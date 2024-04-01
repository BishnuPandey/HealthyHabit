# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WorkoutPlansController, type: :controller do
  login_admin                                          
  let(:valid_attributes) { attributes_for(:workout_plan, user_id: user.id).with_indifferent_access }
  let(:invalid_attributes) { attributes_for(:workout_plan, user_id: nil) }

  describe 'GET /index' do
     it 'assigns workout_plans' do
      WorkoutPlan.create! valid_attributes
      all_workout_plans = WorkoutPlan.where(user_id: user.id)
                                     .includes(:user)
                                     .order(id: :desc)
                                     .all
      get :index
      expect(assigns(:workout_plans)).to eq(all_workout_plans)
    end

    it 'renders the :index view' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      workout_plan = WorkoutPlan.create! valid_attributes
      get :show, params: { "id": workout_plan.id }
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      workout_plan = WorkoutPlan.create! valid_attributes
      get :edit, params: { id: workout_plan.id }
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    # context 'with valid parameters' do
    #   it 'creates a new WorkoutPlan' do
    #     expect do
    #       post :create, params: { workout_plan: valid_attributes }
    #     end.to change(WorkoutPlan, :count).by(1)
    #   end

    #   it 'redirects to the created workout_plan' do
    #     post :create, params: { workout_plan: valid_attributes }
    #     expect(response).to redirect_to(workout_plans_url)
    #   end
    # end

    context 'with invalid parameters' do
      it 'does not create a new WorkoutPlan' do
        expect do
          post :create, params: { workout_plan: invalid_attributes }
        end.to change(WorkoutPlan, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post :create, params: { workout_plan: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  # describe 'DELETE /destroy' do
  #   it 'destroys the requested workout_plan' do
  #     workout_plan = WorkoutPlan.create! valid_attributes
  #     expect do
  #       delete :destroy, params: { "id": workout_plan.id }
  #     end.to change(WorkoutPlan, :count).by(-1)
  #   end

  #   it 'redirects to the workout_plans list' do
  #     workout_plan = WorkoutPlan.create! valid_attributes
  #     delete :destroy, params: { "id": workout_plan.id }
  #     expect(response).to redirect_to(workout_plans_url)
  #   end
  # end
end
