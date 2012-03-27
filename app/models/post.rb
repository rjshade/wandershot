class Post
  include Mongoid::Document
  include Mongoid::Slug
  include Mongoid::Timestamps

  field :title, :type => String
  slug :title

  field :text, :type => String
  field :image_path, :type => String

  belongs_to :story
end
