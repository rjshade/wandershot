class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  field :text, :type => String

  belongs_to :post
  belongs_to :user
end
