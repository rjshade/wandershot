class Story
  include Mongoid::Document
  include Mongoid::Slug

  field :title, :type => String
  slug :title

  field :summary, :type => String

  belongs_to :user
  has_many :posts
end
