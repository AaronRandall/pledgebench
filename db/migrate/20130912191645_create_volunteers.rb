class CreateVolunteers < ActiveRecord::Migration
  def change
    create_table :volunteers do |t|
      t.string :firstname
      t.string :surname
      t.string :email
      t.string :password

      t.timestamps
    end
  end
end
