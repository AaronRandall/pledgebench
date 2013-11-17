class Listing < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :title, :description
  validates_inclusion_of :is_remote, :in => [true, false]
end
