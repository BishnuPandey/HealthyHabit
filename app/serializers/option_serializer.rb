# frozen_string_literal: true

class OptionSerializer < ActiveModel::Serializer
  attributes :id, :question, :options
end
