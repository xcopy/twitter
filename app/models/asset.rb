# Use STI and polymorphic model for multiple uploads
# Read more: http://rails-bestpractices.com/posts/2010/08/18/use-sti-and-polymorphic-model-for-multiple-uploads/
class Asset < ActiveRecord::Base
  belongs_to :resource, polymorphic: true

  delegate :url, to: :attachment
end
