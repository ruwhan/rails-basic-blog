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
                        :length => { :within => 6..35 },
                        :if => :password_required?

  before_save :encrypt_new_password
  
  def self.authenticate(email, passwd)
    user = find_by_email(email)
    return user if user && user.authenticated?(passwd)
  end
  
  def authenticated?(passwd)
    self.password == encrypt(passwd)
  end
  
  protected
    def encrypt_new_password
      return if password.blank?
      self.password = encrypt(password)
    end
    
    def password_required?
      password.blank? || password.present?
    end
    
    def encrypt(passwd)
      Digest::SHA1.hexdigest(passwd)
    end
end
