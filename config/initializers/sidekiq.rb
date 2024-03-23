redis_url = { url: 'redis://localhost:6379' }
Sidekiq.configure_server do |config|
  config.redis = redis_url
end

Sidekiq.configure_client do |config|
  config.redis = redis_url
end
