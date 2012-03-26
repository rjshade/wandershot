class Story
  include Mongoid::Document
  field :title, :type => String
  field :summary, :type => String

  belongs_to :user
  has_many :posts
end
