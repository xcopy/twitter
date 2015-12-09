# clear tables
ActiveRecord::Base.establish_connection unless ActiveRecord::Base.connected?
ActiveRecord::Base.connection.tables.each do |table|
  next if table == 'schema_migrations'
  ActiveRecord::Base.connection.execute("TRUNCATE #{table}")
end

# register some fake users
users = [{
  full_name: 'Kairat Jenishev',
  screen_name: 'xcopy',
  email: 'xcopy@gmail.com',
  password: 'password',
  password_confirmation: 'password'
}]

10.times do
  screen_name = Faker::Internet.user_name

  users << {
    full_name: Faker::Name.name,
    screen_name: screen_name,
    email: Faker::Internet.free_email(screen_name),
    password: 'password',
    password_confirmation: 'password'
  }
end

users.each do |user|
  User.new(user).save(validate: false)
end

# add some fake statuses
User.all.each do |user|
  10.times do
    user.statuses.create({
      text: Faker::Lorem.paragraph(4, true)
    })
  end
end