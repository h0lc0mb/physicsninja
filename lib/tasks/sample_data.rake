namespace :db do
  desc "Create the physics ninja"
  task populate: :environment do
    admin = User.create!(username: "physicsninja",
                 email: "susan@c4online.com",
                 password: "I2430ZXQZYhackit",
                 password_confirmation: "I2430ZXQZYhackit")
    admin.toggle!(:admin)
  end

  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(username: "genius",
                 email: "genius@ninja.com",
                 password: "foobar",
                 password_confirmation: "foobar")
    admin.toggle!(:admin)
    
    99.times do |n|
      username  = "genius-#{n+1}"
      email = "genius-#{n+1}@ninja.com"
      password  = "password"
      User.create!(username: username,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end

    users = User.all(limit: 6)
    50.times do
      content = Faker::Lorem.paragraph(5)
      users.each { |user| user.questions.create!(content: content) }
    end
  end
end