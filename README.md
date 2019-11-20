# Prerequisite 

* `ruby 2.5.5 or higher`
* `nodejs v0.12.7 or higher`
* Please make sure your database configuration is setup at `config/database.yml` properly.

# How to set up locally
 * Run these commands
 ```
 git clone git@github.com:barek2k2/thinkific.git
 bundle install
 rake db:create RAILS_ENV=development
 rake db:migrate RAILS_ENV=development
 rake db:seed RAILS_ENV=development
 rails s -p 3000
 ```
 * Your Rails app will be viewable on http://localhost:3000/
 * A test user will be created upon running the seed with 
 email `barek2k2@gmail.com` and password `123456`

# How to run test cases
```
rake db:create RAILS_ENV=test
rake db:schema:load RAILS_ENV=test
rspec
```

# Live demo
https://fierce-escarpment-82937.herokuapp.com/

# Already tested and developed into this environment
* Ruby 2.5.5
* Rails 5.2.3
* Ubuntu 18.04.2 LTS
* Rubymine IDE 2017.1.6
* PostgreSQL 10.10
* nodejs 0.12.7

#### Notes
 * Right now Active storage uses local disc for file upload, Heroku live demo may not work for file upload/download.
 However AWS S3 can easily be integrated to store files on cloud via Active Storage.
 * Running tests may be slow because bulk import will import multimedia from online.
  
#### What to consider to make the app more faster
  * By setting up either one of background jobs (sidekiq, resque, que, DelayedJob, etc)
  
###### Any question/concern ? :-)
  * barek2k2@gmail.com