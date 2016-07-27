class AddWeekNumberToGoals < ActiveRecord::Migration[5.0]
  def change
    add_column :goals, :week_number, :integer
  end
end
