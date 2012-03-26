class Story
  include Mongoid::Document
  field :title, :type => String
  field :summary, :type => String

  embedded_in :user
end
