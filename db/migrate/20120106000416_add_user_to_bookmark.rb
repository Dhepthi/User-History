class AddUserToBookmark < ActiveRecord::Migration
  def change
    add_column :bookmarks, :user_id, :integer
  end
end
