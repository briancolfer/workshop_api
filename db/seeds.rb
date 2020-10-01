# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

10.times do
  Person.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name,
                birth_date: Faker::Date.birthday(min_age: 18, max_age: 85))
end

# Previous workshops
10.times do
  name = Faker::University.name + ' Music Workshop'
  start_date = Faker::Date.backward(days: 700)
  end_date = start_date + 5
  Workshop.create(workshop_name: name, description: Faker::Lorem.paragraph(sentence_count: 2),
                  start_date: start_date, end_date: end_date)
end

# Future workshops
10.times do
  name = Faker::University.name + ' Music Workshop'
  start_date = Faker::Date.forward(days: 700)
  end_date = start_date + 5
  Workshop.create(workshop_name: name, description: Faker::Lorem.paragraph(sentence_count: 2),
                  start_date: start_date, end_date: end_date)
end
