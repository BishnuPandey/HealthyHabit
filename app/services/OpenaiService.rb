# frozen_string_literal: true

class OpenaiService
  include HTTParty
  attr_reader :api_url, :options, :query

  def initialize(query)
    @query = query
    @api_url = 'https://api.openai.com/v1/chat/completions'
    @options = {
      headers: {
        'Content-Type' => 'application/json',
        'Authorization' => "Bearer #{Rails.application.credentials[:openai_api_key]}"
      }
    }
  end

  def call
    body = {
      model: 'gpt-3.5-turbo', # Model can be change
      messages: [{ role: 'user', content: query }]
    }
    response = HTTParty.post(api_url, body: body.to_json, headers: options[:headers], timeout: 500)
    return response['choices'][0]['message']['content'] if response.success?

    false
  end
end
