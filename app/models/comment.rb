class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  field :text, :type => String
  validates_presence_of :text

  scope :latest, ascending(:created_at)

  belongs_to :post
  belongs_to :story
  belongs_to :user
end
