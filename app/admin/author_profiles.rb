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
end
