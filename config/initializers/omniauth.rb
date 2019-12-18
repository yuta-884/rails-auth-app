Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter,
  Rails.application.credentials.twitter[:key],
  Rails.application.credentials.twitter[:secret]
end
