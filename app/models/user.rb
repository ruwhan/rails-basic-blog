class User < ActiveRecord::Base
  has_many :posts
  
  attr_accessible :email, :password, :password_confirmation
  validates :email, :presence => true,
                    :length => { :maximum => 35 },
                    :format => { :with => /^[^@][\w.-]+@[\w.-]+[.][a-z]{2,4}$/i }
  validates :password, :confirmation => true,
                        :presence => true,
                        :length => { :within => 6..35 }
end
