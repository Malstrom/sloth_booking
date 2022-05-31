ya# Sloth Booking

Simply way to have self booking system for sports activity

> example app: https://sloth-booking.herokuapp.com/

## Ruby version

    ruby-3.0.0
    "rails", "~> 7.0.3"

## Redis
Redis is used for  rails turbo-stream. First you need to install redis on you pc https://redis.io/docs/getting-started/installation/, after start redis in your pc.

    redis-server 

## Heroku db reset and commands

   1. Drop the database, when SHARED_DATABASE_URL is used:
   
            heroku pg:reset DATABASE
        
   2. Recreate the database with nothing in it:
       
            heroku run rake db:migrate
            
   3. Populate the database with your seed data:
       
            heroku run rake db:seed
            
   4. Steps 2 and 3 can be combined into one command by executing this:
   
            heroku run rake db:setup

## How to run the test suite
    

## Usefull commands 

    heroku logs --tail  
    heroku run rails c 

## Deployment instructions

    heroku run rake db:migrate
    git push heroku master
        
   If running 'git push heroku master' generate error try to run di command:
    
    bundle lock --add-platform x86_64-linux
        
   If still not working probably you nedd to remove from Gemfile.lock 
        
    x86_64-darwin-20
            
   And take only 
   
    x86_64-linux
        