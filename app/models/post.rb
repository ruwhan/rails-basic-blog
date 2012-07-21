class Post < ActiveRecord::Base
  attr_accessible :content, :created_at, :last_updated_at, :title
end
