class CreatePublicationsInfos < ActiveRecord::Migration[5.1]
  def change
    create_table :publications_infos do |t|
      t.integer :publications_count, null: false, default: 0
      t.integer :citations_count, null: false, default: 0
      t.integer :author_profile_id, null: false, index: true
      t.string :year, null: false

      t.timestamps
    end
  end
end
