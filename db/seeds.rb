# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Plan.create!(name: "Initiation", price: 5, questions: 1)
Plan.create!(name: "Novice", price: 9, questions: 1)
Plan.create!(name: "Apprentice", price: 25, questions: 3)
Plan.create!(name: "Journeyman", price: 40, questions: 5)
Plan.create!(name: "Master", price: 75, questions: 10)