# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
  default_password= "123456"

20.times do
  q = User.create first_name:Faker::Name.first_name,
                   last_name:Faker::Name.last_name,
                       email:Faker::Internet.email,
                      summary:Faker::Lorem.sentence,
                      password: default_password,
                      password_confirmation:default_password,
                      description:Faker::Lorem.paragraph,
                      is_available:Faker::Boolean.boolean,
                      approved:Faker::Boolean.boolean,
                      admin: false
end
