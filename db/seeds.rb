# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Plan.create!(name: "Initiation", price: 5, questions: 1)
Plan.create!(name: "Novice", price: 7, questions: 1)
Plan.create!(name: "Raider", price: 19, questions: 3)
Plan.create!(name: "Spy", price: 30, questions: 5)
Plan.create!(name: "Warrior", price: 50, questions: 10)

Example.create!(question: "Porsche acceleration")
Example.create!(question: "Elastic and inelastic collisions")
Example.create!(question: "Dartboard kinematics")
Example.create!(question: "Speed of light")
Example.create!(question: "Particles in orbit")