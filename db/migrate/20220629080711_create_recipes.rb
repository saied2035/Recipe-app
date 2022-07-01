class CreateRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes do |t|
      t.string :name, null: false
      t.time :prepration_time, null:false
      t.time :cooking_time, null: false
      t.text :description, null: false
      t.boolean :public, default:true
      t.numeric :total_price, default: 0
      t.references :user, index:true, foreign_key:true 
      t.timestamps
    end
  end
end
