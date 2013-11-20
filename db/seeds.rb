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

Example.create!(question: "A Porsche 944 Turbo has a rated engine power of 217 hp. 
	30% of the power is lost in the drive train, and 70% reaches the wheels. 
	The total mass of the car and driver is 1500kg, and two-thirds of the weight is over the drive wheels. 
	What is the maximum acceleration of the Porsche on a concrete surface where mu=1.00?")
Example.create!(question: "Ball 1, with a mass of 150g and traveling at 13.0m/s , collides head on with ball 2, 
	which has a mass of 300g and is initially at rest. 
	What are the final velocities of each ball if the collision is perfectly elastic?
	What are the final velocities of each ball if the collision is perfectly inelastic?")
Example.create!(question: "A dart is thrown at a dartboard 2.37 m away. 
	When the dart is released at the same height as the center of the dartboard, it hits the center in .447s. 
	At what angle relative to the floor was the dart thrown?")
Example.create!(question: "Can anything travel faster than the speed of light?")
Example.create!(question: "Dear Physics Ninja: A particle with speed V0 and impact parameter b starts far away 
	from a planet of mass M. Starting from scratch(that is, without using any of the results from earlier), 
	find the distance of closest approach to the planet.")