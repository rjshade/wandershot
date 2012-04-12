class User
  include Mongoid::Document
  include Mongoid::Slug
  include Mongoid::Timestamps
  include Mongoid::Paperclip

  has_mongoid_attached_file :avatar, {
                            :styles => {
                              :thumb    => ['96x96#',     :jpg],
                              :large    => ['800x800>',   :jpg] },
                            :default_url => '/assets/avatar/avatar_default_96x96.png'
                            }.merge(PAPERCLIP_STORAGE_OPTIONS)

  devise :database_authenticatable, :confirmable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable
  field :email,              :type => String, :null => false, :default => ""
  field :encrypted_password, :type => String, :null => false, :default => ""

  ## Confirmable
  field :confirmed_at,         :type => Time
  field :confirmation_sent_at, :type => Time
  field :confirmation_token,   :type => String
  field :unconfirmed_email,    :type => String

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

  ## Omniauth
  field :omniauth_signup, :type => Boolean, :default => false

  ## Name
  field :name
  slug :name
  validates_presence_of :name
  # NOTE: devise deals with validation of email + password

  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :avatar

  has_many :stories, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :authentications, :dependent => :destroy

  # roles, e.g. Admin
  has_and_belongs_to_many :roles

  def first_name
    name.split(' ').first
  end

  def has_role?(role_sym)
    roles.any? { |r| r.name.underscore.to_sym == role_sym }
  end
end
