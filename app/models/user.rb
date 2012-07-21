class User < ActiveRecord::Base
  has_many :posts
  
  attr_accessible :email, :password  
  validates :password, :confirmation => true
end
