# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

unless Admin.exists?(email: 'admin@example.com')
  Admin.create!(
    email: 'admin@example.com',
    password: 'securepassword',
    password_confirmation: 'securepassword'
    admin: true
  )
  puts "Admin user created with email: admin@example.com and password: securepassword"
else
  puts "Admin user already exists with email: admin@example.com"
end