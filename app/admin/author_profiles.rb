ActiveAdmin.register AuthorProfile do
  permit_params :profile_id, :profile_type

  controller do
    def scoped_collection
      super.includes :author
    end
  end
end
