module Authors
  class Sync
    include Interactor::Organizer

    organize Authors::SyncProfileInfo, Authors::SyncPublications, Authors::UpdatePublicationsInfo
  end
end
