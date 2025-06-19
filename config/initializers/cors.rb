Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins "*" # Be more restrictive in production

    resource "*",
      headers: :any,
      methods: [ :get, :post, :put, :patch, :delete, :options, :head ],
      expose: [ "X-Total-Count" ]
  end
end
