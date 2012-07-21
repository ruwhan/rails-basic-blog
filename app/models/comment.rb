class Comment < ActiveRecord::Base
  belongs_to :post
  attr_accessible :comment, :name
  
  validates :name, :presence => true
  validates :comment, :presence => true, :length => { :within => 3..1000 }
end
