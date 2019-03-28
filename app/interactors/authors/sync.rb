module Authors
  class Sync
    include Interactor::Organizer

    organize Authors::SyncPublications, Authors::UpdatePublicationsInfo
  end
end
