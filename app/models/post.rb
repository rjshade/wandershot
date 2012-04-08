class Post
  include Mongoid::Document
  include Mongoid::Slug
  include Mongoid::Timestamps
  include Mongoid::Paperclip

  has_mongoid_attached_file :image, {
                            :styles => {
                              :original => ['1920x1680>', :jpg],
                              :small    => ['200x200>',   :jpg],
                              :medium   => ['400x400>',   :jpg],
                              :large    => ['800x800>',   :jpg] }
                            }.merge(PAPERCLIP_STORAGE_OPTIONS)

  field :date, :type => DateTime

  field :title, :type => String
  slug :title, :scope => :story
  validates :title, presence: true, allow_blank: false, allow_nil: false

  field :text, :type => String

  field :address, :type => String
  field :latitude, :type => String
  field :longitude, :type => String

  belongs_to :story
  delegate :user, :to => :story

  has_many :comments, :dependent => :destroy

  scope :latest, descending(:date)
  scope :recent, lambda{|n| latest.limit(n)}

  def get_date
    date = self.date ? self.date : created_at
    date.strftime('%B %e %Y')
  end

  def get_location
    self.address if self.address
  end

  def self.with_images
    all.find_all{|post| post.image?}
  end

  def static_map
    if self.address
      "http://maps.googleapis.com/maps/api/staticmap?center=Brooklyn+Bridge,New+York,NY&zoom=14&size=300x200&maptype=roadmap&sensor=false".html_safe
    end
  end

  def next
    posts = self.story.posts.latest.to_a
    idx = posts.index(self)
    if idx < (posts.size - 1)
      posts[idx+1]
    end
  end
  def prev
    posts = self.story.posts.latest.to_a
    idx = posts.index(self)
    if idx > 0
      posts[idx-1]
    end
  end
end
