class Addtimestampstoskills < ActiveRecord::Migration[5.0]
  def change
    add_timestamps(:skills, null: true)
  end
end
