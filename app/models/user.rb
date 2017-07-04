# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  first_name             :string
#  last_name              :string
#  mother_last_name       :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  failed_attempts        :integer          default(0), not null
#  unlock_token           :string
#  locked_at              :datetime
#  role_id                :integer
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :confirmable

  validates_presence_of :first_name, :last_name, :mother_last_name, :email, :role
  validates :first_name, :last_name, :mother_last_name, format: {with: /(^[a-zA-Z\sáéíóúü]+$)/}
  before_create :set_default_role

  attr_accessor :current_password

  belongs_to :role
  has_many :attendances

  delegate :name, :scope, :key, to: :role, prefix: true

  scope :not_working, -> { joins(:attendances).where(attendances: {check_in: nil}) }
  scope :late_for_work, -> { joins(:attendances).where('attendances.check_in::time > ?', '9:00:00').uniq }

  # Get the full name of the user.
  def full_name
    "#{self.first_name} #{self.last_name} #{self.mother_last_name}"
  end

  # Capitalizes all the words of the first name.
  def first_name=(s)
    super s.titleize
  end

  # Capitalizes all the words of the last name.
  def last_name=(s)
    super s.titleize
  end

  # Capitalizes all the words of the mother last name.
  def mother_last_name=(s)
    super s.titleize
  end

  # Identifies whether a user has the role God or not.
  def god?
    role and role_key == 'god'
  end

  # Identifies whether a user has the total scope or not.
  def has_total_scope?
    role_scope == 'total'
  end

  private

  # Set the default role to the user.
  def set_default_role
    self.role ||= Role.find_by_key('employee')
  end
end
