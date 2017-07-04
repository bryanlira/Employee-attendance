require 'rails_helper'

describe Attendance do
  it 'should create a new attendance for the god user' do
    user = User.first
    user.attendances.create(check_in: Time.now, check_out: Time.now + 8.hour)
    expect(user.attendances.any?).to eq true
  end

  it 'should create an attendance association with empty values' do
    user = User.first
    user.attendances.create(check_in: nil, check_out: nil)
    expect(user.attendances.first.check_in).to eq nil
  end

  it 'should generate a random datetime based on the given hours, and should validate that is in the correct range' do
    from = 8
    to = 9
    date = ((rand((Date.today - 15)..Date.today)) + rand(from..to).hour + rand(0..60).minutes).to_datetime
    expect(date.between?(Date.today - 15, Date.today + 1)).to eq true
  end

  it 'should generates the check out date based on the check in date and the given hours.' do
    from = 8
    to = 9
    check_in_date = ((rand((Date.today - 15)..Date.today)) + rand(from..to).hour + rand(0..60).minutes).to_datetime
    check_out_date = (check_in_date.to_date + rand(from..to).hour + rand(0..60).minutes).to_datetime
    expect(check_out_date.between?(Date.today - 15, Date.today + 1)).to eq true
  end
end
