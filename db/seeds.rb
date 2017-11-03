# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

100.times {
User.new(name: Faker::Zelda.character, email: Faker::Internet.email, password: Faker::Number.number(10), avatar_file_name: Faker::Avatar.image).save(validate: false)
}

100.times {
Group.create(name: Faker::Zelda.character)
}

x = 2
y = 1
100.times {
  UserGroup.create(user_id: 1, group_id: y)
  UserGroup.create(user_id: x, group_id: y)
  x += 1
  y += 1
}

100.times {
  Message.create(message: Faker::Lorem.sentence, user_id: 1, group_id: 1)
  Message.create(message: Faker::Lorem.sentence, user_id: 2, group_id: 1)
}

f = 10
10.times {
  Friend.create(user_id: 1, friend_id: f)
  f += 1
}
