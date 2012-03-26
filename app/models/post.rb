class Post
  include Mongoid::Document
  field :title, :type => String
  field :text, :type => String

  belongs_to :story
end
