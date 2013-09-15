class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.integer :user_id
      t.text :title
      t.text :description
      t.datetime :created_on
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
