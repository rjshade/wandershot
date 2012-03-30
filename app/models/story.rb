class Story
  include Mongoid::Document
  include Mongoid::Slug
  include Mongoid::Timestamps

  field :title, :type => String
  slug :title
  validates :title, presence: true, allow_blank: false, allow_nil: false

  field :summary, :type => String

  belongs_to :user
  has_many :posts

  def length_in_days
    if self.posts.size > 0
      (self.posts.last.created_at.to_datetime - self.posts.first.created_at.to_datetime).to_i
    else
      0
    end
  end

  def posts_with_images
    self.posts.find_all{|post| post.image? }
  end
end
