ActiveAdmin.register Author do
  permit_params :first_name, :second_name, :middle_name, :organization_id, :orcid

  controller do
    def scoped_collection
      super.includes :organization
    end
  end

  form do |f|
    inputs do
      input :organization, include_blank: false
      input :first_name
      input :second_name
      input :middle_name
      input :orcid

      has_many :profiles do |f_p|
        f_p.input :profile_type, collection: Enumeration::CITATIONS_DATABASES, include_blank: false
        f_p.input :profile_id, label: "Profile id", required: true
      end
    end

    actions
  end
end
