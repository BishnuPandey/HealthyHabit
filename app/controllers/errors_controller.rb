# frozen_string_literal: true

class ErrorsController < ApplicationController
  layout false

  # skipping CSRF protection is required here to be able to handle requests for js files
  skip_before_action :verify_authenticity_token

  respond_to :html, :js, :css, :json, :text

  def show
    respond_to do |format|
      format.html { render code.to_s, status: code }
      format.js   { head code }
      format.css  { head code }
      format.json { render json: Hash[error: code.to_s], status: code }
      format.text { render text: "Error: #{code}", status: code }
    end
  end

  private

  def code
    params[:code]
  end
end
