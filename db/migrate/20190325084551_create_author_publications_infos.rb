class CreateAuthorPublicationsInfos < ActiveRecord::Migration[5.1]
  def change
    create_table :author_publications_infos do |t|
      t.integer :publications_count, null: false, default: 0
      t.integer :citations_count, null: false, default: 0
      t.integer :author_id, null: false, index: true
      t.string :year, null: false
      t.string :profile_type, null: false

      t.timestamps
    end
  end
end
