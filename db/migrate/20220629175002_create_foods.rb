class CreateFoods < ActiveRecord::Migration[7.0]
  def change
    create_table :foods do |t|
      #  name 
      t.string :name , null: false
      #  measurement unit
      t.string :unit, default: "gram" 
      # price 
      t.float :price, default: 0.0
      #  quantity
      t.integer :quantity, default: 1
      #  user id
      t.references :user, foreign_key: true, index: true
        
      t.timestamps
      end
    end
  end
