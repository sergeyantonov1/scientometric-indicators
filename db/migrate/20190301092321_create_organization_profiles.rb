class CreateOrganizationProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :organization_profiles do |t|
      t.string :profile_type, null: false
      t.string :profile_id, null: false
      t.integer :organization_id, null: false, index: true
    end
  end
end
