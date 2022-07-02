class CreateRecipeFoods < ActiveRecord::Migration[7.0]
  def change
    create_table :recipe_foods do |t|
      t.bigint :quantity, null:false
      t.references :recipe, index:true, foreign_key:true
      t.references :food, index:true, foreign_key:true
      t.timestamps
    end
  end
end
