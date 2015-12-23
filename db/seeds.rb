# clear tables
ActiveRecord::Base.establish_connection unless ActiveRecord::Base.connected?
ActiveRecord::Base.connection.tables.each do |table|
  next if table == 'schema_migrations'
  ActiveRecord::Base.connection.execute("TRUNCATE #{table}")
end

def avatar_url(num = 0)
  URI.parse("http://abs.twimg.com/sticky/default_profile_images/default_profile_#{num}.png")
end

# register some fake users
user_params = {
  description: Faker::Lorem.paragraph(2, true),
  password: 'password',
  password_confirmation: 'password'
}

users = [
  user_params.merge({
    full_name: 'Kairat Jenishev',
    screen_name: 'xcopy',
    email: 'xcopy@gmail.com',
    avatar: User::Avatar.new(attachment: avatar_url)
  })
]

20.times do
  screen_name = Faker::Internet.user_name

  users << user_params.merge({
    full_name: Faker::Name.name,
    screen_name: screen_name,
    email: Faker::Internet.free_email(screen_name),
    avatar: User::Avatar.new(attachment: avatar_url(rand(0..6)))
  })
end

users.each do |user|
  User.new(user).save!(validate: false)
end

# add some fake statuses
User.all.each do |user|
  rand(11..20).times do
    ts = Time.zone.now - [rand(1..3).days, rand(1..23).hours, rand(1..59).minutes].sample
    user.statuses.create({
      content: Faker::Lorem.paragraph(2, true, 2),
      created_at: ts,
      updated_at: ts
    })
  end
end

# create relationships
User.all.each do |user|
  rand(1..10).times do
    sample_user = User.where.not(id: user.id).sample
    user.follow(sample_user) unless user.following?(sample_user)

    sample_status = Status.all.sample
    user.like(sample_status) unless user.liked?(sample_status)
  end
end