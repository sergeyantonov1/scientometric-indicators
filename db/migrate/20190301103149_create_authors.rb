class CreateAuthors < ActiveRecord::Migration[5.1]
  def change
    create_table :authors do |t|
      t.string :first_name, null: false
      t.string :second_name, null: false
      t.string :middle_name
      t.integer :organization_id, null: false, index: true
    end
  end
end
