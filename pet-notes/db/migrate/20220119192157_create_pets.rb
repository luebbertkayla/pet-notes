class CreatePets < ActiveRecord::Migration[6.0]
  def change
    create_table :pets do |t|
      t.integer :user_id 
      t.string :name
      t.string :type
      t.string :nutrition
      t.string :feedings
      t.string :notes
      t.string :img
    end 
  end
end

