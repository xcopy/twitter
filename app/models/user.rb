class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  # Virtual attribute for authenticating by either :screen_name or :email
  # This is in addition to a real persisted field like 'screen_name'
  attr_accessor :login

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup

    login = conditions.delete(:login)

    if login
      where(conditions).where(['lower(screen_name) = :value OR lower(email) = :value', {value: login.downcase}]).first
    else
      where(conditions).first
    end
  end

  has_many :statuses
end
