# frozen_string_literal: true

module HhApp
  def self.redis
    @redis ||= ConnectionPool::Wrapper.new do
      Redis::Namespace.new('healthy-habit', redis: Redis.new)
    end
  end
end
