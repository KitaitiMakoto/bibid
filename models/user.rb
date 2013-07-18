class User < ActiveRecord::Base
  has_many :authentications
  has_many :books

  validates :name, :presence => true, :uniqueness => true, :format => {with: /\A[\w\-]+\z/}
end
