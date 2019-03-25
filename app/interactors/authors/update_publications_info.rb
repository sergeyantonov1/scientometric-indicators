module Authors
  class UpdatePublicationsInfo
    include Interactor

    delegate :author, :publications_info, to: :context

    def call
      publications_info.each do |k, v|
        AuthorPublicationsInfo.find_or_initialize_by(year: k, author: author, profile_type: profile.profile_type).tap do |info|
          info.publications_count = v[:publications]
          info.citations_count = v[:citations]

          info.save!
        end
      end
    end
  end
end
