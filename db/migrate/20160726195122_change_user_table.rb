class ChangeUserTable < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :uid, :gh_uid
    rename_column :users, :token, :gh_token
    add_column :users, :quiz_id, :string
    add_column :users, :quiz_token, :string
    add_column :users, :name, :string
    add_column :users, :nickname, :string
    add_column :users, :email, :string
  end
end
