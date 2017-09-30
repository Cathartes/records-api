# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

print 'Seeding Users...'

users = []
unless User.exists? discord_name: 'Agthor#8442'
  users << {
    email:           'tybot204@gmail.com',
    discord_name:    'Agthor#8442',
    password:        'password',
    membership_type: :member,
    admin:           true
  }
end
unless User.exists? discord_name: 'iDreamPixels#3186'
  users << {
    email:           'justinrlaforge@gmail.com',
    discord_name:    'iDreamPixels#3186',
    password:        'password',
    membership_type: :member,
    admin:           true
  }
end
users << { discord_name: 'Best 2hu#0550' }      unless User.exists? discord_name: 'Best 2hu#0550'
users << { discord_name: 'Jibbers#2487' }       unless User.exists? discord_name: 'Jibbers#2487'
users << { discord_name: 'NicksPatties#4392' }  unless User.exists? discord_name: 'NicksPatties#4392'
users << { discord_name: 'rebble#3220' }        unless User.exists? discord_name: 'rebble#3220'
users << { discord_name: 'RescuePenguin#8507' } unless User.exists? discord_name: 'RescuePenguin#8507'
users << { discord_name: 'Sloth#6910' }         unless User.exists? discord_name: 'Sloth#6910'
User.create! users

puts 'done'

print 'Seeding Teams...'

teams = []
teams << { name: 'Alpha Team' } unless Team.exists? name: 'Alpha Team'
teams << { name: 'Bravo Team' } unless Team.exists? name: 'Bravo Team'
Team.create! teams

puts 'done'

print 'Seeding Record Books...'

record_books = []
unless RecordBook.exists? name: 'Season 1'
  record_books << {
    name:            'Season 1',
    published:       true,
    start_time:      2.weeks.ago,
    end_time:        2.weeks.from_now,
    rush_start_time: 1.week.from_now,
    rush_end_time:   2.weeks.from_now
  }
end
record_books << { name: 'Season 2' } unless RecordBook.exists? name: 'Season 2'
RecordBook.create! record_books

season_one        = RecordBook.find_by! name: 'Season 1'
member_challenges = []
member_challenges << 'First to Die'           unless season_one.challenges.exists? name: 'First to Die'
member_challenges << 'Complete the Story'     unless season_one.challenges.exists? name: 'Complete the Story'
member_challenges << 'Reach Max Level'        unless season_one.challenges.exists? name: 'Reach Max Level'
member_challenges << 'Reach Max Light Level'  unless season_one.challenges.exists? name: 'Reach Max Light Level'
member_challenges << 'First Exotic Kinetic'   unless season_one.challenges.exists? name: 'First Exotic Kinetic'
member_challenges << 'First Exotic Elemental' unless season_one.challenges.exists? name: 'First Exotic Elemental'
member_challenges << 'First Exotic Power'     unless season_one.challenges.exists? name: 'First Exotic Power'
member_challenges << 'First Exotic Armor'     unless season_one.challenges.exists? name: 'First Exotic Armor'
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
User.all.each_with_index do |user, index|
  next unless user.participations.for_record_book(season_one).any?
  Participation.create!(
    record_book:        season_one,
    team:               teams[index % 2],
    user:               user
  )
end

puts 'done'
