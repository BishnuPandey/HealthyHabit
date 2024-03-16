# frozen_string_literal: true

module Avo
  module Resources
    class User < Avo::BaseResource
      self.includes = []
      # self.search = {
      #   query: -> { query.ransack(id_eq: params[:q], m: "or").result(distinct: false) }
      # }

      def fields
        field :id, as: :id
        field :email, as: :text
        field :fullname, as: :text
        field :uid, as: :text
        field :avatar_url, as: :textarea
        field :provider, as: :text
        field :sign_in_count, as: :number
        field :current_sign_in_at, as: :date_time
        field :last_sign_in_at, as: :date_time
        field :current_sign_in_ip, as: :text
        field :last_sign_in_ip, as: :text
        field :confirmation_token, as: :text
        field :confirmed_at, as: :date_time
        field :confirmation_sent_at, as: :date_time
        field :unconfirmed_email, as: :text
        field :failed_attempts, as: :number
        field :unlock_token, as: :text
        field :locked_at, as: :date_time
      end
    end
  end
end
