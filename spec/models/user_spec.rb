require 'rails_helper'

describe User do
  it "It should filter the user's god assistance when his's been absent from work" do
    user = User.first
    3.times do
      user.attendances.create(check_in: Time.now, check_out: Time.now + 8.hour)
    end
    5.times do
      user.attendances.create(check_in: nil, check_out: nil)
    end
    expect(User.not_working.count).to eq 5
  end

  it 'should return true because the God user has a work delay' do
    user = User.first
    user.attendances.create(check_in: '2017-06-29 09:31:00', check_out: '2017-06-28 05:51:00')
    expect(User.late_for_work.where(id: user.id)&.first == user).to eq true
  end

  it 'should display all the users with delays and absence of work because the current user is a God' do
    user = User.first
    if user.has_total_scope?
      object = User.late_for_work
    else
      object = user.attendances
    end
    expect(object.instance_of? User::ActiveRecord_Relation).to eq true
  end

  it 'should display the attendances because the user is a mortal employee' do
    user = User.first
    user.update_attributes(role_id: 2)
    if user.has_total_scope?
      object = User.late_for_work
    else
      object = user.attendances
    end
    expect(object.instance_of? User::ActiveRecord_Relation).to eq false
  end
end
