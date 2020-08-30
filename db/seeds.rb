# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
person_1 = Person.create([{first_name: "Fred", last_name: "Flintstone", birth_date: "1960-01-01"}])
person_2 = Person.create([{first_name: "Wilma", last_name: "Flintstone", birth_date: "1960-01-01"}])
person_3 = Person.create([{first_name:"Baby", last_name: "Example", birth_date:"2020-01-01"}])
workshop_1 = Workshop.create([{workshop_name: 'Humboldt Chamber Music Workshop'},{description: 'Adult chamber music workshop'}])
workshop_2 = Workshop.create([{workshop_name: 'Ruby on Rails beyond the basics'}, {description: 'Beyond the basics of creating a rails app '}])