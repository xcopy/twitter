class Like < ActiveRecord::Base
  default_scope {order(created_at: :desc)}

  belongs_to :status
  belongs_to :user

  after_create do |record|
    record.status.increment!(:likes_count)
  end

  before_destroy do |record|
    record.status.decrement!(:likes_count)
  end
end
