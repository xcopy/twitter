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

  # relationships
  has_many :active_relationships, class_name: 'Relationship', foreign_key: :follower_id
  has_many :passive_relationships, class_name: 'Relationship', foreign_key: :followed_id
  has_many :following, through: :active_relationships,  source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def feed
    user_ids = following.pluck(:id)
    user_ids << id

    Status.includes(:user).where(user_id: user_ids)

    # statuses + Status.includes(:user).where(user: following)
  end

  def recent_status
    statuses.first
  end
end
