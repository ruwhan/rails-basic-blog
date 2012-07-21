class Post < ActiveRecord::Base
  has_many :comment
  attr_accessible :content, :created_at, :last_updated_at, :title
end
