# frozen_string_literal: true

class OptionsController < ApplicationController
  before_action :authorize_admin

  private

  def option_params
    params.permit(:question, :options)
  end
end
