class Volunteer < ActiveRecord::Base
  validates_presence_of :firstname, :surname, :email, :password
  validates_confirmation_of :email, :password
end
