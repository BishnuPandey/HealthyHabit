class StaticPagesController < ApplicationController
  def root
    @response = OpenaiService.new('What is health and healthy habit').call
    render layout: 'landing'
  end
end
