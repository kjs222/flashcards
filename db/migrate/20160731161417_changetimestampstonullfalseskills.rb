class Changetimestampstonullfalseskills < ActiveRecord::Migration[5.0]
  def change
    change_column_null :skills, :updated_at, false
    change_column_null :skills, :created_at, false
  end
end
