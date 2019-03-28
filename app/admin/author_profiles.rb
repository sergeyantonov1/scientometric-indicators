ActiveAdmin.register AuthorProfile do
  menu false

  actions :show, :create, :update, :destroy

  includes :author

  permit_params :profile_id, :profile_type

  controller do
    def destroy
      destroy! do |success, failure|
        success.html { redirect_to admin_author_path(resource.author) }
      end
    end
  end

  show do
    attributes_table do
      row :profile_type
      row :profile_id
    end

    panel "Publications" do
      table_for author_profile.publications do
        column :year
        column :publications_count
        column :citations_count
      end
    end
  end
end
