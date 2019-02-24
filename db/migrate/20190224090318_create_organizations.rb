class CreateOrganizations < ActiveRecord::Migration[5.1]
  def change
    create_table :organizations do |t|
      t.string :name, null: false, uniq: true
      t.string :scopus_id, null: false, index: true
    end
  end
end
