class Relationship < ActiveRecord::Base
  belongs_to :follower, class_name: 'User'
  belongs_to :followed, class_name: 'User'

  after_create do |record|
    record.follower.increment!(:following_count)
    record.followed.increment!(:followers_count)
  end

  before_destroy do |record|
    record.follower.decrement!(:following_count)
    record.followed.decrement!(:followers_count)
  end
end
