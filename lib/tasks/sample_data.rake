namespace :db do
  desc "Create the physics ninja"
  task populate: :environment do
    admin = User.create!(username: "physicsninja",
                 email: "susan@c4online.com",
                 password: "I2430ZXQZYhackit",
                 password_confirmation: "I2430ZXQZYhackit")
    admin.toggle!(:admin)
  end
end