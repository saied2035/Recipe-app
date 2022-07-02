class CreateFoods < ActiveRecord::Migration[7.0]
  def change
    create_table :foods do |t|
      #  name 
      t.string :name , null: false
      #  measurement unit
      t.string :unit
      # price 
      t.numeric :price
      #  quantity
      t.integer :quantity
      #  user id
      t.references :user, foreign_key: true, index: true
        
      t.timestamps
      end
    end
  end
