class CreateUserFollower < ActiveRecord::Migration[5.0]
  def change
    create_table :user_followers do |t|
      t.references :user, foreign_key: true
      t.integer :follower_id
      t.timestamps

    end
  end
end
