# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

User.destroy_all
Project.destroy_all
ProjectUser.destroy_all

20.times do
    User.create(username: Faker::Name.first_name)
end

20.times do
    Project.create(title: "Project #{Faker::Color.color_name}", description: "#{Faker::Food.description}")
end

100.times do
    User.all[rand(User.all.length)].projects << Project.all[rand(Project.all.length)]
end