require 'rails_helper'

RSpec.describe OpenaiService, type: :model do
  describe '#call' do
    let(:query) { 'Test' }
    it 'connects openapi, requests query, and receives response' do
      response = OpenaiService.new(query).call
      expect(response).to be(false)
    end
  end
end
