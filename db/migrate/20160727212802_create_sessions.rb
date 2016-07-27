class CreateSessions < ActiveRecord::Migration[5.0]
  def change
    create_table :sessions do |t|
      t.references :skill, foreign_key: true
      t.integer :duration

      t.timestamps
    end
  end
end
