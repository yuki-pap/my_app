# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: :true,
             activated: true,
             activated_at: Time.zone.now)


99.times do |n|
    name  = Faker::Name.name
    password = "password"
    User.create!(name:  name,
                 email: "example-#{n+1}@railstutorial.org",
                 password:              password,
                 password_confirmation: password,
                 description: "Ruby on Rails",
                 activated: true,
                 activated_at: Time.zone.now)
 end


 10.times do |n|
     name  = Faker::Name.name
     password = "password"
     User.create!(name:  name,
                  email: "example2-#{n+1}@railstutorial.org",
                  password:              password,
                  password_confirmation: password,
                  description: "Aws",
                  activated: true,
                  activated_at: Time.zone.now)
  end




  User.all.each do |user|
    user.studies.create!(
      count: rand(70),
      date: Time.current.strftime("%Y年%m月%d日"),
      content_today: "今日は頑張った！",
      created_at: Time.current
    )
  end


    User.all.each do |user|
      user.time_by_fields.create!(
        color: "red",
        field: "数学",
        count: 10,
        created_at: Time.current
      )
    end

    User.all.each do |user|
      user.time_by_fields.create!(
        color: "yellow",
        field: "国語",
        count: 10,
        created_at: Time.current
      )
    end


    TimeByField.all.each do |f|
      f.time_by_field_todays.create!(
        count:10
      )
    end



User.all.each do |user|
  user.studies.create!(
    count: 5,
    date: Time.current.yesterday.strftime("%Y年%m月%d日"),
    content_today: "今日は頑張った！",
    created_at: Time.current.yesterday,
  )
end

User.all.each do |user|
  user.studies.create!(
    count: 5,
    date: Time.current.ago(2.days).strftime("%Y年%m月%d日"),
    content_today: "今日は集中できた！",
    created_at: Time.current.ago(2.days)
  )
end

users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
