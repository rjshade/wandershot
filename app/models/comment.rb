class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  field :text, :type => String
  validates_presence_of :text

  field :name, :type => String
  field :email, :type => String
  attr_accessor :email_confirmation
  before_validation :check_honeypot
  before_save :either_user_or_email

  scope :latest, ascending(:created_at)

  belongs_to :post
  belongs_to :story
  belongs_to :user

  private
  def check_honeypot
    email_confirmation.blank?
  end
  def either_user_or_email
    result = true
    if self.user.nil?
      if self.name.blank?
        errors.add(:name, "can't be blank" )
        result = false
      end
      if self.email.blank?
        errors.add(:email, "can't be blank" )
        result = false
      end
    end
    result
  end
end
