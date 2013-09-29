class User < ActiveRecord::Base
  has_many :listings

  attr_accessor :password

  before_save do self.email.downcase! end
  before_save :encrypt_password

  validates_presence_of :firstname, :surname, :email, :password, :username
  validates_confirmation_of :email, :password
  validates_uniqueness_of :email, :username

  def self.authenticate(email, password)
    user = find_by_email(email.downcase)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end
  
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
end
