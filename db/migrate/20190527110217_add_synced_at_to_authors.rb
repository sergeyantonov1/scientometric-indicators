class AddSyncedAtToAuthors < ActiveRecord::Migration[5.1]
  def change
    add_column :authors, :synced_at, :datetime
  end
end
