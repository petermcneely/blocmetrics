# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
5.times do
	User.create!(email: Faker::Internet.email,
				 password: Faker::Internet.password)
end

User.create!(email: ENV['STANDARD_EMAIL'],
			 password: ENV['STANDARD_PASSWORD'])

users = User.all

10.times do
	RegisteredApplication.create!(name: Faker::Lorem.word,
								  url: Faker::Internet.url,
								  user: users.where(email: ENV['STANDARD_EMAIL']).first)
end

registered_applications = RegisteredApplication.all

events = ["Event A", "Event B", "Event C", "Event D"]

50.times do
	Event.create!(name: events.sample,
				  registered_application: registered_applications.sample)
end