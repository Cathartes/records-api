# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

print 'Seeding Users...'

User.create! [
  {
    email: 'tybot204@gmail.com',
    discord_name: 'Agthor#8442',
    password: 'password',
    admin: true
  }, {
    email: 'justinrlaforge@gmail.com',
    discord_name: 'iDreamPixels#3186',
    password: 'password',
    admin: true
  }, {
    discord_name: 'Best 2hu#0550',
    password: Faker::Internet.password(6, 72)
  }, {
    discord_name: 'Jibbers#2487',
    password: Faker::Internet.password(6, 72)
  }, {
    discord_name: 'NicksPatties#4392',
    password: Faker::Internet.password(6, 72)
  }, {
    discord_name: 'rebble#3220',
    password: Faker::Internet.password(6, 72)
  }, {
    discord_name: 'RescuePenguin#8507',
    password: Faker::Internet.password(6, 72)
  }, {
    discord_name: 'Sloth#6910',
    password: Faker::Internet.password(6, 72)
  }
]

puts 'done'
