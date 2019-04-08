module Authors
  class SyncProfileInfo
    include Interactor

    delegate :author, to: :context

    def call
      author.profiles.each do |pr|
        attributes = send("sync_#{pr.profile_type}_profile_info", pr)

        next unless attributes.present?

        pr.update(attributes)
      end
    end

    private

    def sync_scopus_profile_info(profile)
      Scopus::SyncProfileInfo.call(profile: profile).info
    end

    def sync_woc_profile_info(profile)
    end

    def sync_elibrary_profile_info(profile)
    end
  end
end
