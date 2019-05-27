# app/interactors/authors/synс.rb

module Authors
  class Sync
    include Interactor::Organizer

    after { context.author.update(synced_at: Time.now) }

    organize Authors::SyncProfileInfo,
      Authors::SyncPublications,
      Authors::UpdatePublicationsInfo
  end
end

