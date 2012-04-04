class User
  include Mongoid::Document
  include Mongoid::Slug
  include Mongoid::Timestamps
  include Mongoid::Paperclip

  has_mongoid_attached_file :avatar, {
                            :styles => {
                              :thumb    => ['64x64#',     :jpg],
                              :medium   => ['400x400>',   :jpg],
                              :large    => ['800x800>',   :jpg] },
                            :default_url => '/assets/avatar/avatar_default_96x96.png'
                            }.merge(PAPERCLIP_STORAGE_OPTIONS)

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable
  field :email,              :type => String, :null => false, :default => ""
  field :encrypted_password, :type => String, :null => false, :default => ""

  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  ## Name
  field :name
  slug :name
  validates_presence_of :name
  # NOTE: devise deals with validation of email + password

  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :avatar

  has_many :stories, :dependent => :destroy
  has_many :comments, :dependent => :destroy
end
