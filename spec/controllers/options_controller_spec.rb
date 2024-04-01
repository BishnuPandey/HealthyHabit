# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OptionsController, type: :controller do
  login_admin

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
      # it 'adds new option' do
      #   options_count = Option.count
      #   post :create, params: attributes_for(:option)
      #   expect(Option.count).to eq(options_count + 1)
      # end

      it "does not add a new option" do
        expect do
          post :create, params: attributes_for(:option, :invalid)
        end.to change(Option, :count).by(0)
      end
    end

    context 'failure' do
      it 'does not store when validation fails' do
        options_count = Option.count
        post :create, params: attributes_for(:option, :invalid)
        expect(Option.count).to eq(options_count)
      end
    end
  end
end
