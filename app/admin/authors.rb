ActiveAdmin.register Author do
  includes :organization, :profiles

  permit_params :first_name, :second_name, :middle_name, :organization_id, :orcid,
    profiles_attributes:[:id, :profile_id, :profile_type]

  filter :first_name
  filter :second_name
  filter :middle_name
  filter :orcid
  filter :organization
  filter :profiles_profile_type, as: :select,
    collection: Enumeration::CITATIONS_DATABASES, label: "Profile Type"
  filter :profiles_profile_id_eq, label: "Profile ID"

  batch_action :generate_chart_for, form: {
    type: Enumeration::CITATIONS_DATABASES,
    start_date: :datepicker,
    end_date:  :datepicker
  } do |ids, inputs|

    redirect_to dashboard_path(
      author_ids: ids,
      start_date: batch_action_params["start_date"],
      end_date: batch_action_params["end_date"]
    )
  end

  action_item :sync, only: :show do
    link_to "Sync Author", sync_admin_author_path, method: :put
  end

  member_action :sync, method: :put do
    result = Authors::Sync.call(author: resource)

    redirect_to resource_path, notice: "Author was successfully synced!"
  end

  controller do
    def create
      result = Authors::Create.call(author_params: permitted_params[:author])
      @author = result.author

      respond_to do |format|
        if result.success?
          format.html { redirect_to admin_author_path(resource) }
        else
          format.html { render :new }
        end
      end
    end

    def batch_action_params
      JSON.parse(params["batch_action_inputs"].gsub('=>', ':'))
    end
  end

  show do
    attributes_table do
      row :first_name
      row :second_name
      row :middle_name
      row :orcid
      row :organization
    end

    panel "Profiles" do
      table_for author.profiles do
        column "ID" do |profile|
          link_to(profile.id, admin_author_profile_path(profile.id))
        end
        column :profile_type
        column "Profile id", :profile_id

        column do |profile|
          link_to("Destroy", admin_author_profile_path(profile), method: :delete,
            data: { confirm: "Are you sure you want to delete this?" })
        end
      end
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
