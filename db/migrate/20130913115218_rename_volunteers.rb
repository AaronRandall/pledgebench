class RenameVolunteers < ActiveRecord::Migration
  def change
    rename_table :volunteers, :users
  end
end
