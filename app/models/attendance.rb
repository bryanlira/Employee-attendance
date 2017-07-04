class Attendance < ActiveRecord::Base
  belongs_to :user
  delegate :full_name, to: :user, prefix: true
end
