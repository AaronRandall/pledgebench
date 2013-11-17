class CreateCharities < ActiveRecord::Migration
  def change
    create_table :charities do |t|
      t.integer :user_id
      t.string :name
      t.string :registered_charity_number
      t.string :website

      t.timestamps
    end
  end
end
