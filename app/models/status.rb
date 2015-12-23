class Status < ActiveRecord::Base
  belongs_to :user

  has_many :likes, dependent: :destroy
  has_many :favorited, through: :likes, source: :user

  default_scope {order(created_at: :desc)}

  delegate :full_name, :screen_name, to: :user, prefix: true, allow_nil: true

  after_create do |record|
    record.user.increment!(:statuses_count)
  end

  after_destroy do |record|
    record.user.decrement!(:statuses_count)
  end

  validates_presence_of :content

  # todo: remove
  def retweets_count
    0
  end

  def show_stats?
    (likes_count || retweets_count) > 0
  end
end
