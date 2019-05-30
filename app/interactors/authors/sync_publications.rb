module Authors
  class SyncPublications
    include Interactor

    delegate :author, :publications_info, to: :context

    before do
      context.publications_info = {}
    end

    def call
      author.profiles.each do |pr|
        publications_info[pr.profile_type] =
          send("sync_#{pr.profile_type}_publications", pr)
      end
    end

    private

    def sync_scopus_publications(profile)
      Scopus::ParsePublications.call(profile: profile).profile_publications
    end

    def sync_wos_publications(profile)
      Wos::ParsePublications.call(profile: profile).profile_publications
    end
  end
end


