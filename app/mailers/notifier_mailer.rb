# frozen_string_literal: true

class NotifierMailer < ApplicationMailer
  default to: 'pandeybishnupd@gmail.com',
          from: 'no-reply@healthyhabit.com'

  def contact_message(first_name, last_name, email, message)
    mail(
      "reply-to": email_address_with_name(email, "#{first_name} #{last_name}"),
      subject: 'New contact form message',
      body: message
    )
  end
end
