# Cathartes Records API

### Dependencies
- Ruby:     v2.4.1
- Postgres: v9.5

### Setup Instructions
1. Install dependencies
2. Run `bundle install`
3. Ensure `config/database.yml` contains your Postgresql username / password
4. Run `rake db:create`
5. Run `rake db:migrate`
6. Run `rake db:seed` (optionally)

### Common Commands
- Start Rails server using Puma: `rails s`
- Run RSpec test suite: `rspec`
