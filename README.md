[![Build Status](https://semaphoreci.com/api/v1/hmlon/room538/branches/master/shields_badge.svg)](https://semaphoreci.com/hmlon/room538)
# Room538
A hostel room control application. It is destined for controlling who is next on things like "cleaning up", "taking out trash" or other actions between you and your roommates.

Deployed to Heroku: https://room538.herokuapp.com/

### Technologies:
- Language: Ruby
- Framework: Rails
- Database: PostgreSQL

## Local development
1. [Install PostgreSQL](https://www.postgresql.org/download/)
2. Run the following commands to install project:
```console
$ git clone https://github.com/hmlON/room538.git
$ cd room538
$ bundle install
$ rails db:create db:setup
$ rails server
```
## Testing
```console
$ rails db:test:prepare
$ rspec
```
