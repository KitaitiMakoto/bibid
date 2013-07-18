class User < ActiveRecord::Base
  has_many :authentications, :dependent => :destroy
  has_many :books, :dependent => :destroy

  validates :name, :presence => true, :uniqueness => true, :format => {with: /\A[\w\-]+\z/}
end
