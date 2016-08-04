class Adddefaultstotables < ActiveRecord::Migration[5.0]
  def change
    change_column_default(:goals, :num_sessions, 1)
    change_column_default(:goals, :session_length, 30)
    change_column_default(:sessions, :duration, 30)
  end
end
