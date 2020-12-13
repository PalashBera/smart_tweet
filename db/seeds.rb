user = User.create!(
  first_name: "Palash",
  last_name: "Bera",
  email: "palashbera1234@gmail.com",
  password: "123456",
  password_confirmation: "123456",
  confirmation_sent_at: Time.current,
  confirmed_at: Time.current + 5.minutes
)

50.times do
  Tweet.create(user: user, message: Faker::Quote.famous_last_words)
end

50.times do
  Tweet.create(user: user, message: Faker::Quote.matz)
end
