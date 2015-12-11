class Status < ActiveRecord::Base
  belongs_to :user

  default_scope {order('created_at DESC')}

  delegate :full_name, :screen_name, to: :user, prefix: true, allow_nil: true

  after_create do |record|
    record.user.increment!(:statuses_count)
  end

  def created_at
    super.strftime '%d %b %Y, %H:%M'
  end
end
