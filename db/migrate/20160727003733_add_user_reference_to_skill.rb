class AddUserReferenceToSkill < ActiveRecord::Migration[5.0]
  def change
    add_reference :skills, :user, foriegn_key: true
  end
end
