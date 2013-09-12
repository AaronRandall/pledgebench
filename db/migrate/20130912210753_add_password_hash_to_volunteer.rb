class AddPasswordHashToVolunteer < ActiveRecord::Migration
  def change
    add_column :volunteers, :password_hash, :string
    add_column :volunteers, :password_salt, :string
    remove_column :volunteers, :password
  end
end
