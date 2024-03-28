# frozen_string_literal: true

class HomesController < ApplicationController
  def index
    # @response = OpenaiService.new('What is health and healthy habit').call
  end

  def new
    @contact = Contact.new
  end

  def create
    params.permit!
    @contact = Contact.new(contact_params)
    if verify_recaptcha(model: @contact)
      NotifierMailer.contact_message(
        @contact.first_name,
        @contact.last_name,
        @contact.email,
        @contact.message
      ).deliver_later
      flash[:message] = 'Your message has been sent successfully.'
      flash[:type] = :success
      redirect_to homes_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:first_name, :last_name, :email, :message)
  end
end
