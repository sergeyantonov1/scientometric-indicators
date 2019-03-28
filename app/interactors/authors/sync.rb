module Authors
  class Sync
    include Interactor::Organizer

    organize Authors::SyncPublications
  end
end
