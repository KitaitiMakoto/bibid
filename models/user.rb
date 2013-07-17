class User < ActiveRecord::Base
  has_many :authentications
  has_many :books
end
