# frozen_string_literal: true

class Contact
  include ActiveModel::Model
  attr_accessor :first_name, :last_name, :email, :message
end
