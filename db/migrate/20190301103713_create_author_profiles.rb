class CreateAuthorProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :author_profiles do |t|
      t.string :profile_type, null: false
      t.string :profile_id, null: false
      t.integer :h_index
      t.integer :author_id, null: false, index: true
    end

    add_index :author_profiles, [:profile_id, :profile_type]
  end
end
