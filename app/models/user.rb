class User < ActiveRecord::Base
  has_many :posts
  
  attr_accessible :email, :password, :password_confirmation  
  validates :password, :confirmation => true
end
