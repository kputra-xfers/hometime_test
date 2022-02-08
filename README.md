# Hometime Test

#### Ruby: 3.0.0
#### Rails: 7.0.1
#### Database: Sqlite3

## Project Description
Temporary webhook service, to get requests from various sources using a single end point.

## Important directories and files
```
/app
  /controllers
	  /v1
      /webhooks
        reservations_controller.rb
    application_controller.rb
  /interactors
    base_interactor.rb
    payload_1_interactor.rb
    payload_2_interactor.rb
  /models
    guest.rb
    reservation.rb
/db
  /migrate
    *_create_guests.rb
    *_create_reservations.rb
  schema.rb
/spec
  /controllers
	  /v1
      /webhooks
        reservations_controller_spec.rb
  /interactors
    payload_1_interactor_spec.rb
    payload_2_interactor_spec.rb
  /models
    guest_spec.rb
    reservation_spec.rb
```

## Install the Project
1. Clone the repository
2. In terminal, move the directory to the cloned repo (i.e `$ cd ~/hometime_test`)
3. Make sure you have installed ruby version `3.0.0`
4. Run bundle install `$ bundle install`

## Running server
1. In terminal, move the directory to the cloned repo
2. Run `$ rails s`

## Running unit test
1. In terminal, move the directory to the cloned repo
2. Run `$ bundle exec rspec`
