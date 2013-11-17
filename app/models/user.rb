class User < ActiveRecord::Base
  has_many :listings
  has_one :charity

  attr_accessor :password

  before_save do self.email.downcase! end
  before_save :encrypt_password

  validates_presence_of :firstname, :surname, :email, :password, :username
  validates_confirmation_of :password
  validates_uniqueness_of :email, :username
  validates :username, format: { with: /\A[a-zA-Z0-9]+\Z/, :message => "cannot contain spaces or special characters" }

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
