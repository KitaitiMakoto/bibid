class User < ActiveRecord::Base
  has_many :authentications, :dependent => :destroy
  has_many :books, :dependent => :destroy

  validates :name, :presence => true, :uniqueness => true, :format => {with: /\A[\w\-]+\z/}, :length => {:in => 1..24}
  validates :lower_name, :presence => true, :uniqueness => true, :format => {:with => /\A[a-z0-1\-_]+\z/}, :length => {:in => 1..24}

  before_validation {self.lower_name = self.name.downcase}
end
