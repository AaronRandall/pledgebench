class Volunteer < ActiveRecord::Base
  attr_accessor :password

  before_save :encrypt_password

  validates_presence_of :firstname, :surname, :email, :password
  validates_confirmation_of :email, :password

  def self.authenticate(email, password)
    volunteer = find_by_email(email)
    if volunteer && volunteer.password_hash == BCrypt::Engine.hash_secret(password, volunteer.password_salt)
      volunteer
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
