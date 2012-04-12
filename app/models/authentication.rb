class Authentication
  include Mongoid::Document
  include Mongoid::Timestamps

  field :user_id,   :type => Integer, :null => false
  field :provider,  :type => String,  :null => false, :default => ""
  field :uid,       :type => String,  :null => false, :default => ""

  belongs_to :user
end
