class AddAvailabilityToListings < ActiveRecord::Migration
  def change
    add_column :listings, :availability, :string
  end
end
