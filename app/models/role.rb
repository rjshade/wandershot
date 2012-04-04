class Role
  include Mongoid::Document
  include Mongoid::Timestamps

  has_and_belongs_to_many :users

  field :name, :type => String
  validates_presence_of :name
end
