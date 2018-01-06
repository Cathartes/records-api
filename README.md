# Cathartes Records API

### Dependencies

* Ruby: v2.5.0
* Postgres: v9.10

### Setup Instructions

1. Install dependencies
2. Run `bundle install`
   1. If on Mac OSX, you may encounter an error installing gem `pg`
      * `gem install pg -v '0.20.0' -- --with-pg-config=/Applications/Postgres.app/Contents/Versions/latest/bin/pg_config`
      * `bundle install`
   2. If on Mac OSX, you may encounter an error installing gem `nokogiri`
      * `brew unlink gcc-4.2`
      * `gem uninstall nokogiri`
      * `xcode-select --install`
      * `bundle install`
   3. If on Max OSX and `nokogiri` still fails
      * `bundle config build.nokogiri --use-system-libraries`
      * `bundle install`
3. Create / configure `.env` in root of the project
4. Set `DATABASE_USERNAME` and `DATABASE_PASSWORD` to your Postgres username / password
5. Run `rake db:create`
6. Run `rake db:migrate`
7. Run `rake db:seed` (optionally)

### Common Commands

* Start Rails server using Puma: `rails s`
* Run RSpec test suite: `rspec`
