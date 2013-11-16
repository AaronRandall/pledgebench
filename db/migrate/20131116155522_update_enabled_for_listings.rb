class UpdateEnabledForListings < ActiveRecord::Migration
  def change
    change_column :listings, :enabled, :boolean, :default => true, :null => false
  end
end
