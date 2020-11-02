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
    * Configure replicat set 
        * `docker exec -it local-wiki-wak-1 bash`
        * `mongo` 
        *       rs.initiate(
                    {
                        _id : 'rs0',
                        members: [
                        { _id : 0, host : "LOCAL_PRIVATE_IP:27011" },
                        { _id : 1, host : "LOCAL_PRIVATE_IP:27012" },
                        { _id : 2, host : "LOCAL_PRIVATE_IP:27013" }
                        ]
                })

* Database initialization

    * `rake bootstrap:all`

* How to run the test suite

    * `bundle exec rspec spec`

* Services (job queues, cache servers, search engines, etc.)

* Setup

    1. `export LOCAL_PRIVATE_IP=` 
    2. Follow steps in `Database creation` section
    3. `bundle install`
    4. `rake bootstrap:all` to initialize mongo collections
    4. `bundle exec sidekiq`
    5. `rails s`
    6. visit [localhost:3000](localhost:3000)