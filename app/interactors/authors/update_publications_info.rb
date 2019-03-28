module Authors
  class UpdatePublicationsInfo
    include Interactor

    delegate :author, :publications_info, to: :context

    def call
      author.profiles.each do |profile|
        publications_info[profile.profile_type].each do |year, counts|
          PublicationsInfo.find_or_initialize_by(year: year, author_profile: profile).tap do |info|
            info.publications_count = counts[:publications]
            info.citations_count = counts[:citations]

            info.save!
          end
        end
      end
    end
  end
end
