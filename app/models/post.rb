class Post < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :tags
  has_many :comments, :dependent => :destroy
  
  attr_accessible :content, :created_at, :last_updated_at, :title, :tag_ids  
  validates :title, :presence => true, :length => { :within => 3..100 }
  validates :content, :presence => true,
                      :length => { :minimum => 10 }
                      
  paginates_per 3
  
  def owned_by?(owner)
    return false unless owner.is_a? User
    user == owner
  end
end
