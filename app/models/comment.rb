class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  field :text, :type => String
  validates_presence_of :text

  belongs_to :post
  belongs_to :user
end
