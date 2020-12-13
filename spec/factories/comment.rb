FactoryBot.define do
  factory :comment do
    message { SecureRandom.hex(100) }
    user
    tweet
  end
end
