# frozen_string_literal: true

require 'rails_helper'
RSpec.describe OptionsController, type: :controller do
  let(:option) { FactoryGirl.create(:option) }

  describe 'GET #index' do
    it 'assigns options' do
      all_options = Option.all
      get :index
      expect(assigns(:options)).to eq(all_options)
    end

    it 'renders the :index view' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #new' do
    it 'assigns option' do
      get :new
      expect(assigns(:option)).to be_instance_of(Option)
    end

    it 'renders the :new view' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'success' do
      it 'adds new option' do
        options_count = Option.count
        post :create, params: { option: { question: 'blah', options: 'blah' } }
        expect(Option.count).to eq(options_count + 1)
      end

      it "redirects to 'options_path' after successful create" do
        post :create, params: { option: { question: 'blah', options: 'blah' } }
        expect(response.status).to be(302)
        expect(response.location).to match(%r{/options/\d+})
      end
    end

    context 'failure' do
      it 'does not store when validation fails' do
        options_count = Option.count
        post :create, params: { option: { question: nil, options: nil } }
        expect(Option.count).to eq(options_count)
      end
    end
  end
end
