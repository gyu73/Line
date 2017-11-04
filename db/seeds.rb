# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 自分のユーザー作成(usersテーブルとfriendsテーブルには全く同じユーザーが入る)
User.new(name: "柳生1", email: "aaa@gmail.com", password: "000000").save(validate: false)
User.new(name: "柳生2", email: "bbb@gmail.com", password: "000000").save(validate: false)

# ダミーユーザー作成(Sign_up時)
99.times {
name = Faker::Zelda.character
email = Faker::Internet.email
file_name = Faker::Avatar.image
User.new(name: name, email: email, password: Faker::Number.number(10), avatar_file_name: file_name).save(validate: false)
}

# 友達追加作成
f = 2
20.times {
  Friend.create(user_id: 1, friend_id: f)
  f += 1
}

# グループ作成(チャット開始)
x = 1
10.times {
Group.create(name: "グループ#{x}", message_created_at: Time.new)
x += 1
}

# グループ作成時にこの２つの中間テーブルにレコード挿入
x = 2
y = 1
200.times {
  UserGroup.create(user_id: 1, group_id: y)
  UserGroup.create(user_id: x, group_id: y)
  x += 1
  y += 1
}

# メッセージ作成(messagesテーブルで一元管理)
100.times {
  message1 = Message.create(message: Faker::Lorem.sentence, user_id: 1, group_id: 1)
  AlreadyRead.create(user_id: 1, message_id: message1.id)
  message2 = Message.create(message: Faker::Lorem.sentence, user_id: 2, group_id: 1)
  AlreadyRead.create(user_id: 2, message_id: message2.id)
}

Friend.create(user_id: 1, friend_id: 100)
# User.create(name: "メッセージまだの人", email: "bbb@gmail.com", password: "000000").save(validate: false)
# UserFriend.create(user_id: 1, friend_id: 101)
