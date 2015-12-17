class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  extend FriendlyId
  friendly_id :screen_name

  has_attached_file :avatar,
    default_url: '//abs.twimg.com/sticky/default_profile_images/default_profile_0_:style.png',
    path: ":rails_root/public/uploads/#{Rails.env}/:class/:id/:style.:extension",
    url: "/uploads/#{Rails.env}/:class/:id/:style.:extension",
    styles: {
      normal: '48x48>',
      bigger: '73x73>',
      mini: '24x24>'
    }

  # todo: other validates_*
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

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

  def as_json(options = nil)
    defaults = {
      only: [:id, :full_name, :screen_name],
      # methods: [...]
    }

    super(defaults.merge(options || {}))
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

  def who_to_follow
    ids = following.pluck(:id)
    ids << id

    User.where.not(id: ids)
  end

  def feed
    user_ids = following.pluck(:id)
    user_ids << id

    Status.includes(:user).where(user_id: user_ids)

    # statuses + Status.includes(:user).where(user: following)
  end
end
