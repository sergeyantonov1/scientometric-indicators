module Authors
  class Create
    include Interactor::Organizer

    organize Authors::Build, Authors::SyncPublications, Authors::Save
  end
end
