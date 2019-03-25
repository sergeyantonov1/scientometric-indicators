class CreateAuthor
  include Interactor::Organizer

  organize CreateAuthorWithProfiles, SyncAuthorPublications
end
