$redis = Redis::Namespace.new("healthy-habit", :redis => Redis.new)