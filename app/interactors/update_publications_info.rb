class UpdatePublicationsInfo
  include Interactor

  delegate :profile, :publications_info, to: :context

  def call
    create_or_update_publications_info
  end

  private

  def create_or_update_publications_info
    publications_info.each do |k, v|
      AuthorPublicationsInfo.find_or_initialize_by(year: k, author: author, profile_type: profile.profile_type).tap do |info|
        info.publications_count = v[:publications]
        info.citations_count = v[:citations]

        info.save!
      end
    end
  end

  def author
    @author ||= profile.author
  end
end
