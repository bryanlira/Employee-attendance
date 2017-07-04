after :roles do
  puts '==> Creating the \'god user\'...'

# Delete all existing records.
  User.delete_all

# Resets the sequence of the id to 1.
  ActiveRecord::Base.connection.reset_pk_sequence!('users')

# Content.
  role = Role.find_by_key('god')

  user = User.new(email: 'god@example.com', password: 'password', password_confirmation: 'password',
                  first_name: 'God', last_name: 'System', mother_last_name: 'User')

  user.role = role
  user.confirm

  employee_role = Role.find_by_key('employee')

  employee = User.new(email: 'employee@example.com', password: 'password', password_confirmation: 'password',
                  first_name: 'Employee', last_name: 'System', mother_last_name: 'User')

  employee.role = employee_role
  employee.confirm

  20.times do
    if rand(1..10) > 9
      employee.attendances.create(check_in: nil, check_out: nil)
    else
      check_in_date = random_hour(8, 9)
      employee.attendances.create(check_in: check_in_date, check_out: check_out_date(check_in_date, 5, 6))
    end
  end
end
