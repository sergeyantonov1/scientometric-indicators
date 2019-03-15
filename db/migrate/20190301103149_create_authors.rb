class CreateAuthors < ActiveRecord::Migration[5.1]
  def change
    create_table :authors do |t|
      t.string :first_name
      t.string :second_name
      t.string :middle_name
      t.integer :organization_id, null: false, index: true
      t.string :orcid, index: true
    end
  end
end
