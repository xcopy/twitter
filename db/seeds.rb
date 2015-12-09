# clear tables
ActiveRecord::Base.establish_connection unless ActiveRecord::Base.connected?
ActiveRecord::Base.connection.tables.each do |table|
  next if table == 'schema_migrations'
  ActiveRecord::Base.connection.execute("TRUNCATE #{table}")
end

# register some fake users
10.times do
  username = Faker::Internet.user_name
  password = Faker::Internet.password

  User.new({
    username: username,
    email: Faker::Internet.free_email(username),
    password: password,
    password_confirmation: password
  }).save(validate: false)
end

# register my user
User.new({
  username: 'xcopy',
  email: 'xcopy@gmail.com',
  password: 'password',
  password_confirmation: 'password'
}).save(validate: false)

# add some fake statuses
User.all.each do |user|
  10.times do
    user.statuses.create({
      text: Faker::Lorem.paragraph(4, true)
    })
  end
end