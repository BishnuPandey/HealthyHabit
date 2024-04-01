# frozen_string_literal: true

module Avo
  module Resources
    class Option < Avo::BaseResource
      self.includes = []
      # self.search = {
      #   query: -> { query.ransack(id_eq: params[:q], m: "or").result(distinct: false) }
      # }

      def fields
        field :id, as: :id
        field :question, as: :text
        field :options, as: :textarea
      end
    end
  end
end
