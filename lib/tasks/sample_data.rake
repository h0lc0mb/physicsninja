namespace :db do
  desc "Create the physics ninja"
  task populate: :environment do
    admin = User.create!(username: "physicsninja",
                 email: "susan@c4online.com",
                 password: "I2430ZXQZYhackit",
                 password_confirmation: "I2430ZXQZYhackit",
                 q_balance: 2)
    admin.toggle!(:admin)
    admin.toggle!(:ninja)
  end

  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(username: "admin",
                 email: "admin@ninja.com",
                 password: "foobar",
                 password_confirmation: "foobar",
                 q_balance: 2)
    admin.toggle!(:admin)

    ninja = User.create!(username: "ninja",
                 email: "ninja@ninja.com",
                 password: "foobar",
                 password_confirmation: "foobar",
                 q_balance: 2)
    ninja.toggle!(:ninja)
    
    99.times do |n|
      username  = "genius-#{n}"
      email = "genius-#{n}@ninja.com"
      password  = "password"
      User.create!(username: username,
                   email: email,
                   password: password,
                   password_confirmation: password,
                   q_balance: 2)
    end

    users = User.all(limit: 6)
    50.times do
      content = Faker::Lorem.paragraph(5)
      users.each { |user| user.questions.create!(content: content) }
    end
  end
end