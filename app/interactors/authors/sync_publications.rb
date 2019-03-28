module Authors
  class SyncPublications
    include Interactor

    delegate :author, :publications_info, to: :context

    before do
      context.publications_info = {}
    end

    def call
      author.profiles.each do |pr|
        data = send("sync_#{pr.profile_type}_publications", pr)

        publications_info[pr.profile_type] = data
      end
    end

    private

    def sync_scopus_publications(profile)
      Scopus::ParsePublications.call(profile: profile).publications_info
    end
  end
end
