class User < ActiveRecord::Base
  attr_accessible :email, :password
  attr_accessor :password
  

  before_save :create_password
  validates :email, :presence => true
  validates :email, :uniqueness => true
  validates :email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create }

def authenticate_password password
	self.password_hash.eql? BCrypt::Engine.hash_secret(password,self.password_salt)
end

def create_password 
	self.password_salt = BCrypt::Engine.generate_salt
	self.password_hash = BCrypt::Engine.hash_secret(password,self.password_salt)
end


end
