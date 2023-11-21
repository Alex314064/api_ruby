require 'faker'

User.destroy_all
Article.destroy_all

10.times do
  User.create(
    email: Faker::Internet.email,
    password: '123456'
  )
end

35.times do
  user = User.all.sample
  Article.create(
    title: Faker::Beer.name,
    content: Faker::Lorem.sentence(word_count: 20),
    user: user,
    private: false
  )
end
