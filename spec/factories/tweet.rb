FactoryBot.define do
  factory :tweet do
    message { SecureRandom.hex(100) }
    user
  end
end
