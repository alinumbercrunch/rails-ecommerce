# config/initializers/aws.rb
Aws.config.update({
  region: Rails.application.credentials.dig(:aws, :region) || 'us-east-1',
  credentials: Aws::Credentials.new(
    Rails.application.credentials.dig(:aws, :access_key_id),
    Rails.application.credentials.dig(:aws, :secret_access_key)
  )
})
