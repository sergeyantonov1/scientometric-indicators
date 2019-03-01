class CreateAuthorProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :author_profiles do |t|
      t.string :profile_type, null: false
      t.string :profile_id, null: false
      t.integer :h_index, null: false
      t.integer :citations_count, null: false
      t.integer :publications_count, null: false
      t.integer :author_id, null: false, index: true
    end
  end
end
