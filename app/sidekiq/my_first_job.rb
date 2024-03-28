# frozen_string_literal: true

class MyFirstJob
  include Sidekiq::Job

  def perform(name, age)
    Rails.logger.debug "I am #{name}, running my first job at #{age}"
  end
end
