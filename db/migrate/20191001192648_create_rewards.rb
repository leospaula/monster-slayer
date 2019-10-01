class CreateRewards < ActiveRecord::Migration[5.2]
  def change
    create_table :rewards do |t|
      t.integer :goal_id, index: true
      t.integer :user_id, index: true

      t.timestamp
    end
  end
end
