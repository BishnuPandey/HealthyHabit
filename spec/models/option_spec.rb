# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Option, type: :model do
  subject do
    described_class.new(question: 'What is your weight?',
                        options: '{Less than 30, 30-45, 45-60, Above 60}')
  end

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a question' do
      subject.question = nil
      expect(subject).not_to be_valid
    end

    it 'is not valid without an options' do
      subject.options = nil
      expect(subject).not_to be_valid
    end
  end
end
