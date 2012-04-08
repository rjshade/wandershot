class Post
  include Mongoid::Document
  include Mongoid::Slug
  include Mongoid::Timestamps
  include Mongoid::Paperclip

  attr_accessor :delete_image
  before_validation { image.clear if delete_image == '1' and !image.dirty? }
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
    if self.address.nil?
      "#{self.latitude}, #{self.longitude}"
    else
      self.address 
    end
  end

  def self.with_images
    all.find_all{|post| post.image?}
  end

  def static_map( width = 300, height = 200, style = "terrain" )
    "http://maps.googleapis.com/maps/api/staticmap?center=#{self.latitude},#{self.longitude}&zoom=14&size=#{width}x#{height}&maptype=#{style}&sensor=false".html_safe
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
