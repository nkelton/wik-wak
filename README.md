# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

    * 2.6.6

* System dependencies

* Configuration

    * `export LOCAL_PRIVATE_IP=` 

* Database creation

    * `docker-compose up -d`

* Database initialization

    * `rake bootstrap:all`

* How to run the test suite

    * `bundle exec rspec spec`

* Services (job queues, cache servers, search engines, etc.)

* Setup

    1. `export LOCAL_PRIVATE_IP=` 
    2. `cd ./docker && docker-compose up -d`
    3. `bundle install`
    4. `rake bootstrap:all` to initialize mongo collections
    4. `bundle exec sidekiq`
    5. `rails s`
    6. visit [localhost:3000](localhost:3000)