# frozen_string_literal: true

class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  after_create :assign_default_role

  has_one :workout_plan

  def assign_default_role
    add_role(:newuser) if roles.blank?
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.id).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.fullname = auth.info.fullname
      user.avatar_url = auth.info.image
      # uncomment the line below to skip confirmation
      # user.skip_confirmation!
    end
  end
end
