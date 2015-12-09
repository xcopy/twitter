class Status < ActiveRecord::Base
  belongs_to :user

  delegate :full_name, :screen_name, to: :user, prefix: true, allow_nil: true
end
