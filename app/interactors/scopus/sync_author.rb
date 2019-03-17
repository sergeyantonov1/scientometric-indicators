class SyncAuthor
  include Interactor

  delegate :profile_ids, to: :context

  def call
    profile_ids.each do |pid|
      sync_profile(pid) unless profile_exists?(pid)
    end
  end

  private

  def profile_exists?(pid)
    AuthorProfile.exists?(
      profile_type: "scopus",
      profile_id: pid
    )
  end

  def sync_profile(pid)
    response = Scopus.sync_author(pid)

    response["author-retrieval-response-list"]["author-retrieval-response"]
  end
end