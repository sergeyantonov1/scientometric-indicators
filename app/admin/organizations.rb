ActiveAdmin.register Organization do
  permit_params :name, profiles_attributes: [:id, :profile_type, :profile_id]

  show do
    attributes_table do
      row :name
    end

    panel "Profiles" do
      table_for organization.profiles do
        column "ID" do |profile|
          link_to(profile.id, admin_organization_profile_path(profile.id))
        end
        column :profile_type
        column "Profile id", :profile_id

        column do |profile|
          link_to("Destroy", admin_organization_profile_path(profile), method: :delete,
            data: { confirm: "Are you sure you want to delete this?" })
        end
      end
    end
  end

  form do |f|
    inputs do
      input :name

      has_many :profiles do |f_p|
        f_p.input :profile_type, collection: Enumeration::CITATIONS_DATABASES, include_blank: false
        f_p.input :profile_id, label: "Profile id", required: true
      end
    end

    actions
  end
end
