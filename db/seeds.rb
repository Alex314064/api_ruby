require 'faker'

Article.destroy_all

35.times do
Article.create(
    title: Faker::Beer.name,
    content: Faker::Lorem.sentence(word_count: 20) )
end

# 10.times do  User.create(
#     email: Faker::Internet.email,
#     password: '123456',
#   )
# end