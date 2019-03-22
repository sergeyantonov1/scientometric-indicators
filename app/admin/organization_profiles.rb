ActiveAdmin.register OrganizationProfile do
  permit_params :organization, :profile_type, :profile_id

  form do |f|
    inputs do
      input :organization, include_blank: false
      input :profile_type, collection: Enumeration::CITATIONS_DATABASES, include_blank: false
      input :profile_id, label: "Profile id", required: true
    end

    actions
  end
end
