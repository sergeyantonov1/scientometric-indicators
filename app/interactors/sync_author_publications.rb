class SyncAuthorPublications
  include Interactor

  delegate :author, to: :context

  def call
    author.profiles.each do |profile|
      send("sync_#{profile.profile_type}_publications", profile)
    end
  end

  private

  def sync_scopus_publications(profile)
    Scopus::SyncPublications.call(profile: profile)
  end
end
