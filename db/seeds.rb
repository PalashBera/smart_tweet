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
  tweet = Tweet.create(user: user, message: SecureRandom.hex(100))

  5.times do
    tweet.comments.create(user: user, message: SecureRandom.hex(100))
  end
end
