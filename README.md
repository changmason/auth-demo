# Auth Demo

## About this project

  This project implements the user registration and authentication flows from scratch, the features include updating the user's profile and requesting password reset. The user's authentication mechanism relies on the class method `has_secure_password` of `ActiveRecord`, and the user's `reset_password_token` is string of 40 characters generated by the `SecureRandom.hex` function. For more details about the specifications, please visit this Trello board https://trello.com/b/bkzMqThb/auth-demo-app


## To start up

  Make sure you have `ruby 2.5.1p57` and PostgreSQL installed on your system. If you don't please update `Gemfile` and `config/database.yml` based on your configurations.

### Build the project

1. Clone and `cd` to the project
2. Run command `bundle install` to install dependencies
3. Run command `rails db:create` to create the database
4. Run command `rails db:migrate` to create the tables

### Run the server

Run command `rails server` to start the development server and play around http://localhost:3000/sign_up

### Run the tests

Run command `bundle exec rspec -f documentation` to run all the tests and output the results in documentation format.