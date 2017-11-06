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
name = 3
email = "g"
98.times {
User.new(name: "ユーザー" + name.to_s, email: "#{email}@g.c", password: "000000").save(validate: false)
name += 1
email += "g"
}

# 友達追加作成
f = 2
20.times {
  Friend.create(user_id: 1, friend_id: f)
  Friend.create(user_id: f, friend_id: 1)
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
20.times {
  UserGroup.create(user_id: 1, group_id: y)
  UserGroup.create(user_id: x, group_id: y)
  x += 1
  y += 1
}

# メッセージ作成(messagesテーブルで一元管理)
x = 1
100.times {
  message1 = Message.create(message: "メッセージ" + x.to_s, user_id: 1, group_id: 1)
  AlreadyRead.create(user_id: 1, message_id: message1.id)
  x += 1
  message2 = Message.create(message: "メッセージ" + x.to_s, user_id: 2, group_id: 1)
  AlreadyRead.create(user_id: 2, message_id: message2.id)
  x += 1
}

Friend.create(user_id: 1, friend_id: 100)
User.new(name: "あ", email: "ccc@gmail.com", password: "000000").save(validate: false)
# User.create(name: "メッセージまだの人", email: "bbb@gmail.com", password: "000000").save(validate: false)
# UserFriend.create(user_id: 1, friend_id: 101)
