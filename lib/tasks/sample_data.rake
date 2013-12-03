namespace :db do
  desc "Create the physics ninja"
  task populate: :environment do
    admin = User.create!(username: "physicsninja",
                 email: "susan@c4online.com",
                 password: "Frankkfurt08",
                 password_confirmation: "Frankkfurt08",
                 q_balance: 0)
    admin.toggle!(:admin)
    admin.toggle!(:ninja)
  end

  desc "Fill database with sample data"
  task populate: :environment do
#    admin = User.create!(username: "admin",
#                 email: "admin@ninja.com",
#                 password: "foobar",
#                 password_confirmation: "foobar",
#                 q_balance: 0)
#    admin.toggle!(:admin)

#    ninja = User.create!(username: "ninja",
#                 email: "ninja@ninja.com",
#                 password: "foobar",
#                 password_confirmation: "foobar",
#                 q_balance: 0)
#    ninja.toggle!(:ninja)
    
#    99.times do |n|
#      username  = "genius-#{n}"
#      email = "genius-#{n}@ninja.com"
#      password  = "password"
#      User.create!(username: username,
#                   email: email,
#                   password: password,
#                   password_confirmation: password,
#                   q_balance: 0)
#    end

#    users = User.all(limit: 6)
#    50.times do
#      content = Faker::Lorem.paragraph(5)
#      users.each { |user| user.questions.create!(content: content) }
#    end
    
    user = User.first
    content = Faker::Lorem.paragraph(5)
    user.questions.create!(content: content)

  end
end