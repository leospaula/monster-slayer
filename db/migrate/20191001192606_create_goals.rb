class CreateGoals < ActiveRecord::Migration[5.2]
  def change
    create_table :goals do |t|
      t.integer :trophy_id, index: true
      t.string :description
      t.string :category
      t.bigint :value
    end
  end
end
