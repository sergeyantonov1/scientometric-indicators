module Scopus
  class SyncPublications
    include Interactor::Organizer

    organize Scopus::ParsePublications, UpdatePublicationsInfo
  end
end
