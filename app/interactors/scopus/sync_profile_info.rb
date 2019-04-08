module Scopus
  class SyncProfileInfo
    include Interactor

    delegate :profile, :info, to: :context

    def call
      context.info = synced_info
    end

    private

    def synced_info
      response = ScopusClient.author_metrics(profile.profile_id)

      {
        h_index: response["author_retrieval_response"]["h_index"]
      }
    end
  end
end
