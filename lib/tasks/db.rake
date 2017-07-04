namespace :db do
  desc 'Fills the database with fake data'
  task fill_database: :environment do
    puts '==> Filling the database...'
    20.times do
      user = User.new(email: Faker::Internet.email, password: 'password', password_confirmation: 'password',
                      first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, mother_last_name: Faker::Name.last_name)
      user.confirm
      20.times do
        if rand(1..10) > 9
          user.attendances.create(check_in: nil, check_out: nil)
        else
          check_in_date = random_hour(8, 9)
          user.attendances.create(check_in: check_in_date, check_out: check_out_date(check_in_date, 5, 6))
        end
      end
    end
  end

  private

  # Generate a random datetime based on the given hours.
  def random_hour(from, to)
    ((rand((Date.today - 15)..Date.today)) + rand(from..to).hour + rand(0..60).minutes).to_datetime
  end

  # Generates the check out date based on the check in date and the given hours.
  def check_out_date(check_in_date, from, to)
    (check_in_date.to_date + rand(from..to).hour + rand(0..60).minutes).to_datetime
  end
end
