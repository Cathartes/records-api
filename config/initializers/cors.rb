# Be sure to restart your server when you modify this file.

# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin AJAX requests.

# Read more: https://github.com/cyu/rack-cors

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    allowed_origins = case ENV['DEPLOYMENT_LEVEL']
                      when 'production'
                        %w[https://records-spa-production.firebaseapp.com]
                      when 'staging'
                        %w[https://records-spa-staging.firebaseapp.com]
                      end

    allowed_origins = %w[http://localhost:3001] if Rails.env.development?
    allowed_origins ||= []

    origins allowed_origins

    resource '*',
             headers: :any,
             expose: %w[X-USER-UID X-USER-TOKEN],
             methods: %i[get post put patch delete options head]
  end
end
