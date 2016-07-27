class CreateGoals < ActiveRecord::Migration[5.0]
  def change
    create_table :goals do |t|
      t.integer :num_sessions
      t.integer :session_length
      t.references :skill

      t.timestamps
    end
  end
end
