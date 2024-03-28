# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  inherit_resources
  protect_from_forgery with: :exception
  layout -> { false if turbo_frame_request? }

  private

  def authorize_admin
    return if current_user&.has_role? :admin

    flash[:error] = 'Unauthorized access'
    redirect_to '/'
  end
end
