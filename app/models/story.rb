class Story
  include Mongoid::Document
  include Mongoid::Slug
  include Mongoid::Timestamps

  field :title, :type => String
  slug :title
  validates :title, presence: true, allow_blank: false, allow_nil: false

  field :summary, :type => String

  belongs_to :user
  has_many :posts, :dependent => :destroy
  has_many :comments, :dependent => :destroy

  scope :latest, descending(:created_at)
  scope :recent, lambda{|n| latest.limit(n)}

  def length_in_days
    if self.posts.size > 0
      (self.posts.last.created_at.to_datetime - self.posts.first.created_at.to_datetime).to_i
    else
      0
    end
  end

  def get_date_range
    first = self.posts.latest.first
    last = self.posts.latest.last

    if first.nil?
      return "#{created_at.day.ordinalize} #{created_at.strftime("%B %Y")}"
    end

    if first.date == last.date
      return "#{first.get_date}"
    elsif first.date.year == last.date.year
      if first.date.month == last.date.month
        return "#{first.date.day.ordinalize} to #{last.date.day.ordinalize} of #{first.date.strftime('%B')} #{first.date.year}"
      else
        return "#{first.date.day.ordinalize} #{first.date.strftime('%B')} to #{last.date.day.ordinalize} #{last.date.strftime('%B')} #{first.date.year}"
      end
    else
      return "#{first.get_date} to #{last.get_date}"
    end
  end

  def self.with_images
    all.find_all{|story| !story.posts_with_images.empty?}
  end

  def posts_with_images
    self.posts.find_all{|post| post.image? }
  end

  def posts_with_locations
    self.posts.find_all{|post| post.latitude && post.longitude}
  end

  def static_map( width = 512, height = 512, type = "terrain" )
    locations = self.posts_with_locations
    markers = ''
    self.posts_with_locations.each{|p| markers += marker(p.latitude,p.longitude)}
    "http://maps.googleapis.com/maps/api/staticmap?size=#{width}x#{height}&maptype=#{type}&#{markers}sensor=false".html_safe
  end

  private
  def marker( lat, lng )
    "markers=color:red%7Ccolor:red%7C#{lat},#{lng}&".html_safe
  end
end
