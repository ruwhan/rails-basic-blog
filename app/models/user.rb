require 'digest'

class User < ActiveRecord::Base
  has_many :posts
  has_many :replies, :through => :posts, :source => :comments
  
  attr_accessible :email, :password, :password_confirmation
  validates :email, :presence => true,
                    :length => { :maximum => 35 },
                    :format => { :with => /^[^@][\w.-]+@[\w.-]+[.][a-z]{2,4}$/i }
  validates :password, :confirmation => true,
                        :presence => true,
                        :length => { :within => 6..35 }

  before_save :encrypt_new_password
  
  protected
    def encrypt_new_password
      return if password.blank?
      self.password = encrypt(password)
    end
    
    def encrypt(string_pwd)
      Digest::SHA1.hexdigest(string_pwd)
    end
end
