# frozen_string_literal: true

class OptionsController < ApplicationController
  private

  def option_params
    params.require(:option).permit(:option_id, :question, :options)
  end
end
