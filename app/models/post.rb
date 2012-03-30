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
                              :large    => ['800x800>',   :jpg] },

                            :path => "/public/:user_slug/stories/:story_slug/:post_slug/:attachment/:id/:style.:extension"
                            }.merge(PAPERCLIP_STORAGE_OPTIONS)

  field :title, :type => String
  slug :title, :scope => :story
  validates_format_of :title, without: /(?i)new/
  validates_format_of :title, without: /(?i)edit/

  field :text, :type => String

  belongs_to :story

  scope :by_date, ascending(:created_at)

  def self.with_images
    all.find_all{|post| post.image?}
  end
end
