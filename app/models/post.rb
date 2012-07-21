class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, :dependent => :destroy
  
  attr_accessible :content, :created_at, :last_updated_at, :title  
  validates :title, :presence => true, :length => { :within => 3..100 }
  validates :content, :presence => true,
                      :length => { :minimum => 10 }
end
