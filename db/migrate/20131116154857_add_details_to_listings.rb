class AddDetailsToListings < ActiveRecord::Migration
  def change
    add_column :listings, :website, :string
    add_column :listings, :is_remote, :boolean
    add_column :listings, :town, :string
    add_column :listings, :county, :string
    add_column :listings, :postcode, :string
    add_column :listings, :enabled, :boolean
  end
end
