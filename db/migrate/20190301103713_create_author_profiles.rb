class CreateAuthorProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :author_profiles do |t|
      t.string :profile_type, null: false
      t.string :profile_id, null: false
      t.integer :h_index
      t.integer :citations_count
      t.integer :publications_count
      t.integer :author_id, null: false, index: true
    end
  end
end
