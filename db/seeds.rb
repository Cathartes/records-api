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
    email:        'tybot204@gmail.com',
    discord_name: 'Agthor#8442',
    password:     'password',
    admin:        true
  }, {
    email:        'justinrlaforge@gmail.com',
    discord_name: 'iDreamPixels#3186',
    password:     'password',
    admin:        true
  }, {
    discord_name: 'Best 2hu#0550',
    password:     Faker::Internet.password(6, 72)
  }, {
    discord_name: 'Jibbers#2487',
    password:     Faker::Internet.password(6, 72)
  }, {
    discord_name: 'NicksPatties#4392',
    password:     Faker::Internet.password(6, 72)
  }, {
    discord_name: 'rebble#3220',
    password:     Faker::Internet.password(6, 72)
  }, {
    discord_name: 'RescuePenguin#8507',
    password:     Faker::Internet.password(6, 72)
  }, {
    discord_name: 'Sloth#6910',
    password:     Faker::Internet.password(6, 72)
  }
]

puts 'done'

print 'Seeding Teams...'

Team.create! [
  {
    name: 'Alpha Team'
  }, {
    name: 'Bravo Team'
  }
]

puts 'done'

print 'Seeding Record Books...'

RecordBook.create! [
  {
    name:            'Season 1',
    published:       true,
    start_time:      2.weeks.ago,
    end_time:        2.weeks.from_now,
    rush_start_time: 1.week.from_now,
    rush_end_time:   2.weeks.from_now
  }, {
    name:            'Season 2'
  }
]

season_one        = RecordBook.find_by! name: 'Season 1'
member_challenges = [
  'First to Die',
  'Complete the Story',
  'Reach Max Level',
  'Reach Max Light Level',
  'First Exotic Kinetic',
  'First Exotic Elemental',
  'First Exotic Power',
  'First Exotic Armor'
]
Challenge.create!(member_challenges.map do |challenge|
  {
    record_book:     season_one,
    name:            challenge,
    max_completions: 1,
    points: [
      1 => 9,
      2 => 6,
      3 => 3,
      0 => 1
    ]
  }
end)

teams = Team.all
users = User.all
Participation.create!(users.each_with_index.map do |user, index|
  {
    record_book:        season_one,
    team:               teams[index % 2],
    user:               user,
    participation_type: :member
  }
end)

puts 'done'
