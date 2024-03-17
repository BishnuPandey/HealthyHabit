# frozen_string_literal: true

class Option < ApplicationRecord
  validates :question, :options, presence: true
end
