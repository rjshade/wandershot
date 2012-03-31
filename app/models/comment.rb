class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  field :text, :type => String
  validates_presence_of :text

  scope :newest_first, descending(:created_at)

  belongs_to :post
  belongs_to :user
end
