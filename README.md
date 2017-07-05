# Employee Attendance

Employee Attendance is a system that focuses primarily on managing the attendance of your employees.

### Features

- Authentication with Devise.
- Dynamically authorization with Pundit.
- Tests with Rspec.
- Good code quality since doesn't contain any error with rails_best_practices.
- Internationalization with 99% for Spanish and English.
- Administrative panel to manage users, roles and permissions.
- Panel to manage the assistance of the employees.
- Configuration of environment variables with Figaro (to send mails).
- AdminLTE control panel template.
- Database with PostgreSQL.

### Requirements

- Rails 4.2.6+
- PostgreSQL
- Ruby 2.3.0+

### Installation

Install Ruby on Rails 4.2.6+

Install required Gem and dependencies.

    bundle install

Create database structure.

    rake db:create
    rake db:migrate
    rake db:seed

Fill the database with fake information.

    rake db:fill_database 
    
To configure the mailer you should create the file `application.yml` in the following path:

    app/config/application.yml
    
The `application.yml` should contain the following code:

    MAILER_DOMAIN: your_domain
    MAILER_USERNAME: your_username
    MAILER_PASSWORD: your_password
    
Start your server

    rails server # and then go to your browser http://localhost:3000/
    
To access the application as an administrator, use the following account:
    
    email: god@example.com
    password: password
    
To access the application as an employee, use the following account:
    
    email: employee@example.com
    password: password
    
### Run Rspec Tests
 
To run the Rspec tests, you should be on the path of the project.

    [~/Desktop/EmployeeAttendance]$     

Then, follow the next commands to create the test database:

    rake db:create RAILS_ENV=test 
    rake db:migrate RAILS_ENV=test
    rake db:seed RAILS_ENV=test
     
Finally, you will be able to run the Rspec tests by using this command:
      
    bundle exec rspec      