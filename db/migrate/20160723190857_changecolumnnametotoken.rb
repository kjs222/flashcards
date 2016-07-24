class Changecolumnnametotoken < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :oauth_token, :token
  end
end
