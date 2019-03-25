ActiveAdmin.register OrganizationProfile do
  menu false

  actions :show, :create, :update, :destroy

  permit_params :organization, :profile_type, :profile_id

  controller do
    def destroy
      destroy! do |success, failure|
        success.html { redirect_to admin_organization_path(resource.organization) }
      end
    end
  end

  form do |f|
    inputs do
      input :organization, include_blank: false
      input :profile_type, collection: Enumeration::CITATIONS_DATABASES, include_blank: false
      input :profile_id, label: "Profile id", required: true
    end

    actions
  end
end
