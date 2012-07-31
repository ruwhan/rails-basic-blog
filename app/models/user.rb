require 'digest'

class User < ActiveRecord::Base
  has_many :posts
  has_many :replies, :through => :posts, :source => :comments
  
  attr_accessible :email, :password, :password_confirmation, :verified, :token
  attr_accessor :update_password
  validates :email, :presence => true,
					:uniqueness => true,
                    :length => { :maximum => 35 },
                    :format => { :with => /^[^@][\w.-]+@[\w.-]+[.][a-z]{2,4}$/i }
  validates :password, :confirmation => true,
                        :presence => true,
                        :length => { :within => 6..35 },
                        :if => :password_required? && :should_validate_password?

  before_save :encrypt_new_password
  
  def self.authenticate(email, passwd)
    user = find_by_email(email)
    return user if user && user.authenticated?(passwd)
  end
  
  def authenticated?(passwd)
    (self.password == encrypt(passwd)) && self.verified
  end
  
  def should_validate_password?
    update_password || new_record?
  end
  
  protected
    def encrypt_new_password
      return if password.blank?
      if update_password || new_record?
        self.password = encrypt(password)
      end
    end
    
    def password_required?
      password.blank? || password.present?
    end
    
    def encrypt(passwd)
      Digest::SHA1.hexdigest(passwd)
    end
end
