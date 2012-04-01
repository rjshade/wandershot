class Post
  include Mongoid::Document
  include Mongoid::Slug
  include Mongoid::Timestamps
  include Mongoid::Paperclip

  has_mongoid_attached_file :image, {
                            :styles => {
                              :original => ['1920x1680>', :jpg],
                              :thumb    => ['100x100#',   :jpg],
                              :medium   => ['400x400>',   :jpg],
                              :large    => ['800x800>',   :jpg] }

                            }.merge(PAPERCLIP_STORAGE_OPTIONS)

  field :title, :type => String
  slug :title, :scope => :story
  validates :title, presence: true, allow_blank: false, allow_nil: false

  field :text, :type => String

  field :address, :type => String
  field :latitude, :type => String
  field :longitude, :type => String

  belongs_to :story
  belongs_to :user

  has_many :comments, :dependent => :destroy

  scope :by_date, ascending(:created_at)

  def self.with_images
    all.find_all{|post| post.image?}
  end
end
